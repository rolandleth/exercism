export const validate = (number) => {
	if (number < 10) {
		return true
	}

	if (number < 100) {
		return false
	}

	const n = `${number}`
	const result = n.split("").reduce((prev, current) => {
		const value = parseInt(current, 10)

		return prev + value ** n.length
	}, 0)

	return result == number
}
