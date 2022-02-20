#stolen from https://adamfontenot.com/post/how_i_defeated_wordle_with_python

import collections
import enum
import random


class Tip(enum.Enum):
    ABSENT = 0
    PRESENT = 1
    CORRECT = 2


def score(secret, guess):
    """Scores a guess word when compared to a secret word.
    Makes sure that characters aren't over-counted when they are correct.
    For example, a careless implementation would flag the first “s”
    of “swiss” as PRESENT if the secret word were “chess”.
    However, the first “s” must be flagged as ABSENT.
    To account for this, we start by computing a pool of all the relevant characters
    and then make sure to remove them as they get used.
    """

    # All characters that are not correct go into the usable pool.
    pool = collections.Counter(s for s, g in zip(secret, guess) if s != g)
    # Create a first tentative score by comparing char by char.
    score = []
    for secret_char, guess_char in zip(secret, guess):
        if secret_char == guess_char:
            score.append(Tip.CORRECT)
        elif guess_char in secret and pool[guess_char] > 0:
            score.append(Tip.PRESENT)
            pool[guess_char] -= 1
        else:
            score.append(Tip.ABSENT)

    return score


def filter_words(words, guess, score):
    """Filter words to only keep those that respect the score for the given guess."""

    new_words = []
    for word in words:
        # The pool of characters that account for the PRESENT ones is all the characters
        # that do not correspond to CORRECT positions.
        pool = collections.Counter(c for c, sc in zip(word, score) if sc != Tip.CORRECT)
        for char_w, char_g, sc in zip(word, guess, score):
            if sc == Tip.CORRECT and char_w != char_g:
                break  # Word doesn't have the CORRECT character.
            elif char_w == char_g and sc != Tip.CORRECT:
                break  # If the guess isn't CORRECT, no point in having equal chars.
            elif sc == Tip.PRESENT:
                if not pool[char_g]:
                    break  # Word doesn't have this PRESENT character.
                pool[char_g] -= 1
            elif sc == Tip.ABSENT and pool[char_g]:
                break  # ABSENT character shouldn't be here.
        else:
            new_words.append(word)  # No `break` was hit, so store the word.

    return new_words


def get_random_word(words):
    print(f"Word Pool: {len(words)} Words.")
    guess = random.choice(words)
    print(f"Try {guess!r}.")
    return guess

def play_with_computer(words):
    length = 5
    words = [word for word in words if len(word) == length]

#This is the bit @31Carlton7 needs to care about: it needs to return the mapping in accordance with the following - the linking is his job. 

    mapping = {"0": Tip.ABSENT, "1": Tip.PRESENT, "2": Tip.CORRECT}
    print(f"\nNOTE: when typing scores, use {mapping}.\n")
    while len(words) > 1:
        guess = get_random_word(words)
        #print("How did this guess score?")
        user_input = input(">>> ") #Right here, this should receive input from the front-end, go through the code, and return a response. This too is 31Carlton7's job. 
        sc = [mapping[char] for char in user_input if char in mapping]
        words = filter_words(words, guess, sc)
        print()

    return words


if __name__ == "__main__":
    WORD_LST = "Words.txt"  # Point to a file with a word per line.

    with open(WORD_LST, "r") as f:
        words = [word.strip() for word in f.readlines()]

    words = play_with_computer(words)

    if not words:
        raise RuntimeError("I don't know any words that could solve the puzzle...")
    print(f"The secret word must be {words[0]!r}!")
