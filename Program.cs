using Microsoft.Data.SqlClient;
using System.IO;
namespace Extrados_txt_reader

{
    internal class Program
    {
        static void Main(string[] args)
        {
            string txtLocaciones = "locaciones.txt";
            string txtEmpleados = "empleados.txt";
            string txtDepartamentos = "departamentos.txt";
            string connectionString = "Server=ADMIN;Database=ExtradosDB;Trusted_Connection=True;TrustServerCertificate=True;";
            using (StreamReader reader = new StreamReader(txtDepartamentos))
            {
                string linea;
                List<string> lista = new List<string>();
                while ((linea = reader.ReadLine()) != null)
                {
                    if (linea.StartsWith('+'))
                    {
                        continue;
                    }
                    if (linea.StartsWith('|'))
                    {
                        linea = linea.Trim('|');//saco los | del principio
                        
                        string[] columnas = linea.Split('|'); //separo las columnas por |
                        
                        for (int i = 0; i <columnas.Length; i++)
                        {
                            if (string.IsNullOrWhiteSpace(columnas[i]))
                            {
                                columnas[i] = "NULL";
                            }
                            else
                            {
                                columnas[i] = columnas[i].Trim();
                                
                            }
                        }
                        string resultado = string.Join(",", columnas);
                        
                        lista.Add(resultado);
                    }
                }
                //Console.WriteLine($"INSERT INTO locaciones ({lista[0]}) " + $"VALUES ({lista[1]})");
                string[] values = lista[1].Split(',');

                //problema a solucionar: el tipo de dato dentro de los insert es string...
                //foreach (var item in values)
                //{
                //    Console.WriteLine($"Value: {item.Trim()}, Type: {item.GetType()}");
                //}
                string locacionQuery;
                foreach (var row in lista)
                {
                    

                    locacionQuery = $"INSERT INTO departamentos ({lista[0]}) " + $"VALUES ({row})";
                    Console.WriteLine(locacionQuery);
                    //Console.WriteLine(locacionQuery);
                }
                //        using (SqlCommand command = new SqlCommand(locacionQuery, connection))

                using (SqlConnection connection = new SqlConnection(connectionString))
                {


                    connection.Open();
                    Console.WriteLine("Conectado exitosamente a SQL Server");

                //    foreach (var row in lista)
                //    {
                //        locacionQuery = $"INSERT INTO locaciones ({lista[0]}) " + $"VALUES {row}";
                //        using (SqlCommand command = new SqlCommand(locacionQuery, connection))
                //        {
                //            int filasAfectadas = command.ExecuteNonQuery();
                //            if (filasAfectadas > 0)
                //            {
                //                Console.WriteLine("Inserción de datos exitosa");
                //            }
                //            else
                //            {
                //                Console.WriteLine($"Hubo un fallo en la fila {row}");
                //            }
                //        }
                //    }
                }
            }
        }
        //TODO :
        //eliminar los titulos de columnas y aplicarlas estaticamente
        // usar Console.ReadLine para elegir el tipo de valor y formatear columnas en vez de hacerlo automaticamente
        //por las dudas que haya campos dudosos...
    }
}
