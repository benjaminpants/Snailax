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

            Logger.Log("Added string: " + str);

            return st;
        }

        public static UndertaleRoom.GameObject AddObjectToLayer(this UndertaleRoom room, UndertaleData data, string objectname, string layername)
        {
            UndertaleRoom.GameObject obj = new UndertaleRoom.GameObject()
            {
                InstanceID = data.GeneralInfo.LastObj++,
                ObjectDefinition = data.GameObjects.ByName(objectname),
                X = 0,
                Y = 0
            };
            room.Layers.First(layer => layer.LayerName.Content == layername).InstancesData.Instances.Add(obj);

            return obj;
        }

        //PREY THAT I CAN DEPRECATE THIS FUNCTION IN THE FUTURE
        public static void AppendGMLSafe(this UndertaleCode code, string gml, UndertaleData data)
        {
            try
            {
                code.AppendGML(gml, data);
            }
            catch (Exception) { }

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

            data.Code.Add(code);

            data.Scripts.Add(scr);

            Logger.Log("Added script: " + scriptname);

            return scr;

        }

    }
}
