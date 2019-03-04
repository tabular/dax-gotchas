using System;
using Microsoft.AnalysisServices.Xmla; // Add Reference - it is part of the bin directory of Power BI Desktop
using System.Threading;

namespace SSASClearCache
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Server:");
            string server = Console.ReadLine();

            Console.Write("Database:");
            string database = Console.ReadLine();

            Console.Write("WaitIntervalInMiliSeconds:");
            string interval = Console.ReadLine();
            int waitIntervalInMiliSeconds;
            Int32.TryParse(interval, out waitIntervalInMiliSeconds);

            XmlaClient clnt = new XmlaClient();

            int counter = 0;
            while (true)
            {
                clnt.Connect(server);

                string xmla = String.Format(@"<ClearCache xmlns=""http://schemas.microsoft.com/analysisservices/2003/engine"">  
                                    <Object>
                                        <DatabaseID>{0}</DatabaseID>
                                    </Object >
                                </ClearCache>", database);

                Console.WriteLine("Clearing cache (counter=" + counter + ")");

                clnt.Send(xmla, null);

                clnt.Disconnect();

                Thread.Sleep(waitIntervalInMiliSeconds);

                counter++;
            }
        }
    }
}