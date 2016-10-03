import Foundation

func flattenArray<T>(_ array: [Any?]) -> [T] {
	var output: [T] = []
	
	for element in array.flatMap({ $0 }) {
		guard let t = element as? T else {
			let flat: [T] = flattenArray(element as! [Any?])
			
			for e in flat {
				output.append(e)
			}
			
			continue
		}
		
		output.append(t)
	}
	
	return output
}
