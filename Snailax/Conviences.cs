using GmmlPatcher;
using UndertaleModLib;
using UndertaleModLib.Models;
using System;

namespace Snailax
{
    public static class Conviences
    {
        public static UndertaleString CreateAndSaveString(this UndertaleData data, string str)
        {
            UndertaleString st = new UndertaleString();

            st.Content = str;

            data.Strings.Add(st);

            Console.WriteLine("Added string: " + str);

            return st;
        }

        public static UndertaleScript CreateScript(this UndertaleData data, string scriptname, string gml, ushort arguments = 0)
        {
            UndertaleScript scr = new UndertaleScript();
            UndertaleCode code = new UndertaleCode();
            scr.Name = data.CreateAndSaveString(scriptname);
            try
            {
                code.AppendGML(gml, data);
            }
            catch (Exception) { };
            code.ArgumentsCount = arguments;
            scr.Code = code;

            data.Scripts.Add(scr);

            Console.WriteLine("Added script: " + scriptname);

            return scr;

        }

    }
}
