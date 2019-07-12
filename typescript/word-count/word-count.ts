export default class Words {
  count = (phrase: string): Map<string, number> => {
    return phrase
      .trim()
      .toLowerCase()
      .split(/\s+/)
      .reduce((accumulator, word) => {
        return accumulator.set(word, (accumulator.get(word) || 0) + 1)
      }, new Map())
  }
}
