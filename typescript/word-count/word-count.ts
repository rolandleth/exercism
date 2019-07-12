export default class Words {
  count = (phrase: string) => {
    const result: Map<string, number> = new Map()

    phrase
      .trim()
      .replace(/[\s\t\n]+/, " ")
      .split(" ")
      .forEach((e) =>
        result.set(e.toLowerCase(), (result.get(e.toLowerCase()) || 0) + 1)
      )

    return result
  }
}
