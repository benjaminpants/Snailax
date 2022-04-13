using GmmlPatcher;
using UndertaleModLib;
using UndertaleModLib.Models;
using System;
using WysApi.Api;
using System.IO;
using TSIMPH;
using UndertaleModLib.Decompiler;
using System.Reflection;
using GmmlHooker;

namespace Snailax
{
    public class GameMakerMod : IGameMakerMod
    {

        public static Dictionary<string,string> GMLkvp = new Dictionary<string,string>();

        public static GlobalDecompileContext? GDC;

        

        public static bool LoadGMLFolder(string gmlfolder)
        {
            return GMLkvp.LoadGMLFolder(gmlfolder);
        }

        public static UndertaleScript CreateScriptFromKVP(UndertaleData data, string name, string key, ushort arguments)
        {
            return Hooker.CreateLegacyScript(name, GMLkvp[key], arguments);
        }

        public void Load(int audioGroup, ModData currentMod)
        {
            UndertaleData data = Patcher.data;
            string soundsfolder = Path.Combine(currentMod.path, "Sounds");
            Conviences.AddAudioFolder(audioGroup, 2, soundsfolder);
            if (audioGroup != 0) return;
            GDC = new GlobalDecompileContext(data,false);
            //supress vs being stupid
            string gmlfolder = Path.Combine(currentMod.path,"GMLSource");



            LoadGMLFolder(gmlfolder);

            LoadGMLFolder(Path.Combine(gmlfolder,"Scripts"));

            LoadGMLFolder(Path.Combine(gmlfolder, "LevelEditorObjects"));

            LoadGMLFolder(Path.Combine(gmlfolder, "LevelEditorObjects", "EditorScripts"));

            LoadGMLFolder(Path.Combine(gmlfolder, "CreationCode"));

            // create playerspawn before everything else
            UndertaleGameObject playerspawn_object = new UndertaleGameObject();

            playerspawn_object.Name = data.Strings.MakeString("obj_playerspawn");

            playerspawn_object.Sprite = data.Sprites.ByName("spr_player");

            data.GameObjects.Add(playerspawn_object);

            CreateScriptFromKVP(data, "scr_get_item_sprite_index", "gml_GlobalScript_scr_get_item_sprite_index",1);

            CreateScriptFromKVP(data, "scr_getitemoffsets",  "gml_GlobalScript_scr_getitemoffsets", 1);

            CreateScriptFromKVP(data, "scr_rotate_object", "gml_GlobalScript_scr_rotate_object", 3).Code.LocalsCount = 1;


            try
            {

                data.Code.First(code => code.Name.Content == "gml_Object_obj_epilepsy_warning_Create_0")
                    .AppendGML("txt_1 = \"INCOMPLETE WARNING\"\ntxt_2 = \"Snailax may be more bug-prone then usual. \nYou can access the level editor in the extras menu. \nBTW the patch file was literally generated from GMML's cache.\"", data);
            }
            // UndertaleModLib is trying to write profile cache but fails, we don't care
            catch (Exception) { /* ignored */ }

            //Create the level editor object
            UndertaleGameObject level_editor_object = new UndertaleGameObject();

            data.GameObjects.Add(level_editor_object);

            level_editor_object.Name = data.Strings.MakeString("obj_level_editor");

            CreateScriptFromKVP(data, "scr_editor_save", "scr_editor_save", 0).Code.LocalsCount = 1;

            CreateScriptFromKVP(data, "scr_editor_load", "scr_editor_load", 0).Code.LocalsCount = 1;

            CreateScriptFromKVP(data, "scr_editor_play", "scr_editor_play", 0).Code.LocalsCount = 1;

            CreateScriptFromKVP(data, "scr_editor_tile_merge", "scr_editor_tile_merge", 0).Code.LocalsCount = 1;

            CreateScriptFromKVP(data, "scr_editor_get_layer", "scr_editor_get_layer", 1).Code.LocalsCount = 1;

            level_editor_object.Sprite = data.Sprites.ByName("spr_wall_original");

            level_editor_object.EventHandlerFor(EventType.Create, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_level_editor_Create_0"]);

            level_editor_object.EventHandlerFor(EventType.Step, EventSubtypeStep.Step, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_level_editor_Step_0"]);

            level_editor_object.EventHandlerFor(EventType.Draw, EventSubtypeDraw.Draw, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_level_editor_Draw_0"]);

            level_editor_object.EventHandlerFor(EventType.Draw, EventSubtypeDraw.DrawGUI, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_level_editor_Draw_64"]);

            UndertaleGameObject stupid_levelstyler = new UndertaleGameObject();

            stupid_levelstyler.Name = data.Strings.MakeString("obj_i_hate_levelstylers");

            stupid_levelstyler.ParentId = data.GameObjects.ByName("obj_levelstyler");

            stupid_levelstyler.EventHandlerFor(EventType.Create, data.Strings, data.Code, data.CodeLocals)
                .AppendGMLSafe(GMLkvp["gml_Object_obj_i_hate_levelstylers_Create_0"]);

            data.GameObjects.Add(stupid_levelstyler);

            
            UndertaleGameObject editor_music_obj = new UndertaleGameObject();

            editor_music_obj.Name = data.Strings.MakeString("obj_music_editor");

            editor_music_obj.ParentId = data.GameObjects.ByName("obj_music_parent");

            editor_music_obj.EventHandlerFor(EventType.Other, EventSubtypeOther.User0, data.Strings, data.Code, data.CodeLocals).AppendGMLSafe("play_music = sou_editor_theme");

            data.GameObjects.Add(editor_music_obj);

            Logger.Log("Created all objects!");


            // copy the room of funny and create the editor room

            UndertaleRoom newroom = Conviences.CreateBlankLevelRoom("snailax_editor_room");

            newroom.SetupRoom(false);

            newroom.AddObjectToLayer(data, "obj_level_editor", "Goal");

            newroom.AddObjectToLayer(data, "obj_i_hate_levelstylers", "PostProcessing");

            newroom.AddObjectToLayer(data, "obj_post_processing_draw", "PostProcessing");

            newroom.AddObjectToLayer(data, "obj_music_editor", "FadeOutIn");

            newroom.SetupRoom(false);


            data.Rooms.Add(newroom);

            UndertaleRoom.GameObject vic = newroom.AddObjectToLayer(data, "obj_go_to_room_victory", "Goal");

            vic.X = -528;
            vic.Y = -642;
            vic.ScaleX = 5000;
            vic.ScaleY = 5000;

            vic.CreationCode = data.CreateCode("gml_ObjectCC_obj_go_to_room_victory_editor_Create", "go_to_room = snailax_editor_room");
            
            //create the hehe funny portal

            UndertaleRoom levelselect = data.Rooms.First(room => room.Name.Content == "level_select");

            UndertaleRoom.GameObject gameobj = levelselect.GameObjects.First(obj => obj.ObjectDefinition.Name.Content == "obj_player");

            //UndertaleRoom.GameObject portal = levelselect.AddObjectToLayer(data,"obj_level_select_portal","Goal");

            //portal.X = gameobj.X - 120;
            //portal.Y = gameobj.Y - 240;

            //portal.CreationCode = data.CreateCode("gml_ObjectCC_obj_level_select_portal_Create",GMLkvp["gml_ObjectCC_obj_level_select_portal_Create"],0);

            //BULK REGISTER (your mother)

            Dictionary<string, string> OverrideScripts = GMLKVP.DictionarizeGMLFolder(Path.Combine(gmlfolder, "Overrides"));

            Dictionary<string, string> FrontScripts = GMLKVP.DictionarizeGMLFolder(Path.Combine(gmlfolder, "FrontScripts")); //not implemented, but these would append themselves to the front of the GML of whatever script they are using

            Dictionary<string, string> AppendScripts = GMLKVP.DictionarizeGMLFolder(Path.Combine(gmlfolder, "AppendScripts"));

            data.GameObjects.ByName("obj_squasher").EventHandlerFor(EventType.Alarm, (uint)4, data.Strings,data.Code,data.CodeLocals).AppendGMLSafe(GMLkvp["gml_Object_obj_squasher_Alarm_4"]);

            data.GameObjects.ByName("obj_wall_walkthrough").EventHandlerFor(EventType.Draw, EventSubtypeDraw.Draw, data.Strings, data.Code, data.CodeLocals).AppendGMLSafe(GMLkvp["gml_Object_obj_wall_walkthrough_Draw_0"]);


            foreach (KeyValuePair<string, string> kvp in OverrideScripts)
            {
                UndertaleCode code = data.Code.First(c => c.Name.Content == kvp.Key);
                if (code != null)
                {
                    try
                    {
                        code.ReplaceGML(kvp.Value, data);
                    }
                    catch (Exception) {/* die */}
                }
            }

            foreach (KeyValuePair<string, string> kvp in FrontScripts)
            {
                UndertaleCode code = data.Code.First(c => c.Name.Content == kvp.Key);
                if (code != null)
                {
                    string newcode = kvp.Value + "\n" + code.DecompileGML();
                    try
                    {
                        code.ReplaceGML(newcode, data);
                    }
                    catch (Exception) {/* die */}
                }
            }

            foreach (KeyValuePair<string, string> kvp in AppendScripts)
            {
                UndertaleCode code = data.Code.First(c => c.Name.Content == kvp.Key);
                if (code != null)
                {
                    code.AppendGMLSafe(kvp.Value);
                }
            }

            //create this after the rooms been created so the room is properly defined
            
            CreateScriptFromKVP(data, "scr_warp_menu", "gml_GlobalScript_scr_warpmenu", 1);

            Menus.InsertMenuOptionFromEnd(Menus.Vanilla.Extras, 0, new Menus.WysMenuOption("\"Level Editor\"") //visual studio kept screaming at me
            {
                script = "scr_warp_menu",
                tooltipScript = Menus.Vanilla.Tooltips.Text,
                tooltipArgument = "\"Warp to the level editor\""
            });


        }
    }
}