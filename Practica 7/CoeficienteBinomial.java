import java.util.Scanner;

public class CoeficienteBinomial{

    public static void main(String[] args){
        System.out.println("Coeficiente Binomial");
        int[] numeros = recibirNumeros();
        int resultado = coeficienteBinomial(numeros[0], numeros[1]);
        System.out.println("El coeficiente binomial de " + numeros[0] + " y " + numeros[1] + " es: " + resultado);
    }

    private static int[] recibirNumeros(){
        Scanner scaner = new Scanner(System.in);
        int numeros[] = new int[2];
        System.out.print("Ingrese un número: ");
        String numero = scaner.nextLine();
        try {
            numeros[0] = Integer.parseInt(numero);
        } catch (NumberFormatException nfe) {
            numeros[0] = 0;
        }
        System.out.print("Ingrese el segundo número: ");
        numero = scaner.nextLine();
        try {
            numeros[1] = Integer.parseInt(numero);
        } catch (NumberFormatException nfe) {
            numeros[1] = 0;
        }
        return numeros;
    }

    private static int coeficienteBinomial(int a, int b){
        if(b > a)
            return 0;
        if(a > 0 && b == 0)
            return 1;
        if(a == 0 && b > 0)
            return 0;
        if(a == b)
            return 1;
        return coeficienteBinomial(a - 1, b - 1) + coeficienteBinomial(a - 1, b);
    }
}