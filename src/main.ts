import { mergeSort } from "./mergeSort";

// Array de exemplo
const arr: number[] = [38, 27, 43, 3, 9, 82, 10];

console.log("Array original:", arr);

const sorted = mergeSort(arr);
console.log("Array ordenado:", sorted);
