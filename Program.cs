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

            Console.WriteLine("Seleccione la DB que quiera agregar a mssql");
            var dbSeleccionada = Console.ReadLine().ToLower() + ".txt";
            
            string connectionString = "Server=ADMIN;Database=ExtradosDB;Trusted_Connection=True;TrustServerCertificate=True;";
            using (StreamReader reader = new StreamReader(dbSeleccionada))
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

                        for (int i = 0; i < columnas.Length; i++)
                        {
                            if (columnas[i]?.Trim() == "0") //si hay un 0, lo seteo a NULL
                            {
                                columnas[i] = "NULL";
                            }
                            if (string.IsNullOrWhiteSpace(columnas[i])) //si hay espacios vacios, los seteo a NULL
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
                lista.Remove(lista[0]);
                List<string> listaDeValores = new List<string>();//elimino el titulo de las tablas, las asigno estaticamente

                
                //problema a solucionar: el tipo de dato dentro de los insert es string...

                //foreach (var item in values)
                //{
                //    Console.WriteLine($"Value: {item.Trim()}, Type: {item.GetType()}");
                //}

                string locacionQuery;
                foreach (var row in lista)
                {
                    if (dbSeleccionada == "locaciones.txt")
                    {
                        locacionQuery = $"INSERT INTO locaciones ( ID_LOCACION, DIRECCION , CODIGO_POSTAL, CIUDAD, ESTADO_PROVINCIA, ID_PAIS) " + $"VALUES ({row})";
                        Console.WriteLine(locacionQuery);
                    }
                    else if (dbSeleccionada == "departamentos.txt")
                    {
                        locacionQuery = $"INSERT INTO departamentos (ID_DEPARTAMENTO, NOMBRE, ID_MANAGER, ID_LOCACION) " + $"VALUES ({row})";
                        Console.WriteLine(locacionQuery);
                    }
                    else if (dbSeleccionada == "empleados.txt")
                    {
                        locacionQuery = $"INSERT INTO empleados (ID_EMPLEADO, NOMBRE, APELLIDO, EMAIL, TELEFONO, FECHA_EN, ID_TRABAJO, SALARIO, COMISION, ID_MANAGER, ID_DEPARTAMENTO) " + $"VALUES ({row})";
                        Console.WriteLine(locacionQuery);
                    }
                    else {
                        Console.WriteLine("La DB no existe o ingresaste mal el nombre");
                        return;
                    }
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
