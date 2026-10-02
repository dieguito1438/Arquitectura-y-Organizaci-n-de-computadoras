import java.util.Scanner;

/**
 * Clase para calcular la serie de Leibniz
 */
public class serieLeibniz{

    /**
     * Metodo main, el corazón del programa.
     * @param args, la lista de argumentos que recibe el programa.
     */
    public static void main(String[] args){
        System.out.println("Serie de Leibniz");
        // Recibimos el número del usuario.
        int n = recibirNumero();
        // Calculamos el valor de la sumatoria.
        double m = sumatoria(n);
        // Lo multiplicamos por 4.
        m = 4 * m;
        // Imprimimos el resultado.
        System.out.println("El resultado es: " + m);
    }

    /**
     * Recibe y regresa un número ingresado por el usuario.
     * @return int.
     */
    private static int recibirNumero(){
        Scanner sc = new Scanner(System.in);
        System.out.print("Ingresa un número: ");
        String numero = sc.next();
        int n;
        try {
            n = Integer.parseInt(numero);
        } catch (NumberFormatException nfe) {
            return 0;
        }
        return n;
    }

    /**
     * Calcula la parte de la sumatoria de la serie
     * de Leibniz.
     * @param n, el valor que tomara la sumatoria (de 0 a n).
     * @return double, el resultado de hacer la suma desde 0
     * hasta n.
     */
    private static double sumatoria(int n){
        double resultado = 0;
        for(int i = 0; i <= n; i++){
            resultado = resultado + (Math.pow(-1, i) / (2*i + 1));
        }
        return resultado;
    }

}