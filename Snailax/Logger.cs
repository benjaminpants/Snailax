using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Snailax
{
    public static class Logger
    {
        public enum LogLevel
        {
            Debug,
            Info,
            Warn,
            Error,
            Fatal
        }


        public static void Log(string log, Logger.LogLevel level = LogLevel.Debug)
        {
            switch(level)
            {

                case LogLevel.Error:
                    Console.BackgroundColor = ConsoleColor.Red;
                    Console.ForegroundColor = ConsoleColor.White;
                    break;

                case LogLevel.Warn:
                    Console.BackgroundColor = ConsoleColor.Red;
                    Console.ForegroundColor = ConsoleColor.White;
                    break;

                case LogLevel.Debug:
                    Console.ForegroundColor = ConsoleColor.Gray;
                    break;

                default:
                    break;

            }
            Console.WriteLine(log);
            Console.ResetColor();
        }
    }
}
