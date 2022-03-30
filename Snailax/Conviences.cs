using GmmlPatcher;
using UndertaleModLib;
using UndertaleModLib.Models;
using System;

namespace Snailax
{
    public static class Conviences
    {

        //this is now just an alias, deprecation?
        public static UndertaleString CreateAndSaveString(this UndertaleData data, string str)
        {

            Logger.Log("Added string: " + str);

            return data.Strings.MakeString(str);
        }

        public static UndertaleRoom.GameObject AddObjectToLayer(this UndertaleRoom room, UndertaleData data, string objectname, string layername)
        {
            data.GeneralInfo.LastObj++;
            UndertaleRoom.GameObject obj = new UndertaleRoom.GameObject()
            {
                InstanceID = data.GeneralInfo.LastObj,
                ObjectDefinition = data.GameObjects.ByName(objectname),
                X = 0,
                Y = 0
            };

            room.Layers.First(layer => layer.LayerName.Content == layername).InstancesData.Instances.Add(obj);

            room.GameObjects.Add(obj);

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

        public static UndertaleCode CreateCode(this UndertaleData data, string name, string gml, ushort arguments = 0)
        {
            UndertaleCode code = new UndertaleCode();
            code.Name = data.CreateAndSaveString(name);
            try
            {
                code.AppendGML(gml, data);
            }
            catch (Exception) { };
            code.ArgumentsCount = arguments;

            data.Code.Add(code);

            return code;
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

            code.Name = data.CreateAndSaveString("GlobalScript_" + scriptname);

            data.Code.Add(code);

            data.Scripts.Add(scr);

            Logger.Log("Added script: " + scriptname);

            return scr;

        }

    }
}
