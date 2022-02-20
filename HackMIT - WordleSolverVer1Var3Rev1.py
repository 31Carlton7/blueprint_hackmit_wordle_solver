# Author: Andrey Kobyakov

import collections
import enum
import random
#import nltk

guesses = 0


class Tip(enum.Enum):
    ABSENT = 0
    PRESENT = 1
    CORRECT = 2


def levenshtein(a, b):
    m = [[*range(len(a) + 1)] for _ in range(len(b) + 1)]
    for i in range(len(b) + 1):
        m[i][0] = i
    for i in range(1, len(b) + 1):
        for j in range(1, len(a) + 1):
            m[i][j] = min(m[i-1][j] + 1, m[i][j-1] + 1,
                          m[i-1][j-1] + (b[i-1] != a[j-1]))
    return m[-1][-1]


def score(secret, guess):
    pool = collections.Counter(s for s, g in zip(secret, guess) if s != g)
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
    new_words = []
    for word in words:
        pool = collections.Counter(c for c, sc in zip(
            word, score) if sc != Tip.CORRECT)
        for char_w, char_g, sc in zip(word, guess, score):
            if sc == Tip.CORRECT and char_w != char_g:
                break  # Word doesn't have the CORRECT character.
            elif char_w == char_g and sc != Tip.CORRECT:
                # If the guess isn't CORRECT, no point in having equal chars.
                break
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
    global guesses
    if guesses != 0:
        guesses += 1
        print(f"Word Pool: {len(words)} Words.")
        guess = random.choice(words)
        print(f"Try {guess!r}.")
        file = open("GuessGiven.txt", "w")
        # file.truncate(0)
        file.write(guess)
        file.close()

        file = open("wordle_solver_app/assets/GuessGiven.txt", "w")
        # file.truncate(0)
        file.write(guess)
        file.close()
        return guess
    else:
        guesses += 1
        guess = "soare"
        file = open("GuessGiven.txt", "w")
        file.write(guess)
        file.close()

        file = open("wordle_solver_app/assets/GuessGiven.txt", "w")
        # file.truncate(0)
        file.write(guess)
        file.close()

        print(f"Try {guess!r}.")
        return guess


def play_with_computer(words):
    length = 5
    words = [word for word in words if len(word) == length]

# This is the bit @31Carlton7 needs to care about: it needs to return the mapping in accordance with the following - the linking is his job.

    mapping = {"0": Tip.ABSENT, "1": Tip.PRESENT, "2": Tip.CORRECT}
    print(f"\nNOTE: when typing scores, use {mapping}.\n")
    while len(words) > 1:
        guess = get_random_word(words)
        #print("How did this guess score?")
        # Right here, this should receive input from the front-end, go through the code, and return a response. This too is 31Carlton7's job.
        user_input = input(">>> ")
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
        raise RuntimeError(
            "I don't know any words that could solve the puzzle...")
    print(f"The word is {words[0]!r}.")
