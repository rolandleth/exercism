export const reverseString = (string) =>
	string.split("").reduce((prev, current) => current + prev, "")
