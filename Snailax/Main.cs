using GmmlPatcher;
using UndertaleModLib;
using UndertaleModLib.Models;
using System;
using System.IO;
using System.Reflection;

namespace Snailax
{
    public static class GameMakerMod
    {

        public static Dictionary<string,string> GMLkvp = new Dictionary<string,string>();


        public static bool LoadGMLFolder(string gmlfolder)
        {


            try
            {
                string[] infos = Directory.GetFiles(gmlfolder);

                for (int i = 0; i < infos.Length; i++)
                {
                    FileInfo fo = new FileInfo(infos[i]);
                    //fo.Name
                    if (fo.Extension == ".gml")
                    {
                        Console.WriteLine("Reading File: " + fo.Name);
                        GMLkvp.Add(Path.GetFileNameWithoutExtension(fo.Name), File.ReadAllText(infos[i]));
                    }
                }
            }
            catch
            {
                Console.BackgroundColor = ConsoleColor.Red;
                Console.ForegroundColor = ConsoleColor.White;
                Console.WriteLine("Failed to read/open: " + gmlfolder);
                Console.ForegroundColor = ConsoleColor.Black;
                Console.BackgroundColor = ConsoleColor.Yellow;
                Console.WriteLine("Expect strange behavior or future crashes!");
                Console.ResetColor();
                return false;
            }

            return true;
        }

        public static void CreateScriptFromKVP(UndertaleData data, string key, ushort arguments)
        {
            data.CreateScript(key, GMLkvp[key], arguments);
        }

        public static void Load(UndertaleData data, IEnumerable<ModMetadata> queuedMods)
        {

            //supress vs being stupid
            #pragma warning disable CS8604
            string gmlfolder = Path.Combine(Path.GetDirectoryName(Assembly.GetExecutingAssembly().Location),"GMLSource");
            #pragma warning restore CS8604

            LoadGMLFolder(gmlfolder);

            LoadGMLFolder(Path.Combine(gmlfolder,"Scripts"));

            LoadGMLFolder(Path.Combine(gmlfolder, "LevelEditorObject"));

            CreateScriptFromKVP(data, "gml_GlobalScript_scr_get_item_sprite_index",1);

            CreateScriptFromKVP(data, "gml_GlobalScript_scr_getitemoffsets", 1);

            CreateScriptFromKVP(data, "gml_GlobalScript_scr_rotate_object", 3);

            try
            {
                
                data.Code.First(code => code.Name.Content == "gml_Object_obj_epilepsy_warning_Create_0")
                    .AppendGML("txt_1 = \"Snailax works lol\"", data);

                UndertaleGameObject level_editor_object = new UndertaleGameObject();

                level_editor_object.Name = data.CreateAndSaveString("obj_level_editor");

                level_editor_object.EventHandlerFor(EventType.Create, data.Strings, data.Code, data.CodeLocals)
                    .AppendGML(GMLkvp["gml_Object_obj_level_editor_Create_0"],data);

                data.GameObjects.Add(level_editor_object);
            }
            // UndertaleModLib is trying to write profile cache but fails, we don't care
            catch (Exception) { /* ignored */ }
        }
    }
}