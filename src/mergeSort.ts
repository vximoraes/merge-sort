// Função principal do Merge Sort
// Etapa 1: Função recursiva que divide o array
export function mergeSort(arr: number[]): number[] {
	if (arr.length <= 1) {
		console.log("Retornando:", arr);
		return arr;
	}

	// Etapa 2: Encontrar o meio do array
	const mid = Math.floor(arr.length / 2);
	const left = arr.slice(0, mid);
	const right = arr.slice(mid);

	console.log(`Dividindo: [${arr}] em [${left}] e [${right}]`);

	const sortedLeft = mergeSort(left);
	const sortedRight = mergeSort(right);

	// Etapa 3: Mesclar as duas metades ordenadas
	const merged = merge(sortedLeft, sortedRight);
	console.log(`Mesclando: [${sortedLeft}] e [${sortedRight}] => [${merged}]`);
	return merged;
}

// Função auxiliar para mesclar dois arrays ordenados
// Etapa 4: Mesclagem dos subarrays
function merge(left: number[], right: number[]): number[] {
	const result: number[] = [];
	let i = 0, j = 0;

	// Etapa 5: Comparar elementos e adicionar ao resultado
	while (i < left.length && j < right.length) {
		if (left[i] <= right[j]) {
			result.push(left[i++]);
		} else {
			result.push(right[j++]);
		}
	}

	// Etapa 6: Adicionar elementos restantes
	return result.concat(left.slice(i)).concat(right.slice(j));
}
