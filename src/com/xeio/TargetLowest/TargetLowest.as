import com.GameInterface.Game.TeamInterface;
import com.Utils.Archive;

class TargetLowest
{    
	private var m_swfRoot: MovieClip;
	
	public static function main(swfRoot:MovieClip):Void 
	{
		var bagUtil = new TargetLowest(swfRoot);
		
		swfRoot.onLoad = function() { bagUtil.OnLoad(); };
		swfRoot.OnUnload =  function() { bagUtil.OnUnload(); };
		swfRoot.OnModuleActivated = function(config:Archive) { bagUtil.Activate(config); };
		swfRoot.OnModuleDeactivated = function() { return bagUtil.Deactivate(); };
	}
	
    public function TargetLowest(swfRoot: MovieClip) 
    {
		m_swfRoot = swfRoot;
    }
	
	public function OnUnload()
	{
		TeamInterface.SignalClientJoinedTeam.Disconnect(TeamJoin, this);
		TeamInterface.SignalClientLeftTeam.Disconnect(TeamLeave, this);
		TeamInterface.SignalClientJoinedRaid.Disconnect(TeamJoin, this);
		TeamInterface.SignalClientLeftRaid.Disconnect(TeamLeave, this);
		
		com.GameInterface.Input.RegisterHotkey(_global.Enums.InputCommand.e_InputCommand_Target_FriendlyNext, "", _global.Enums.Hotkey.eHotkeyDown, 0);
	}
	
	public function Activate(config: Archive)
	{
	}
	
	public function Deactivate(): Archive
	{
		var archive: Archive = new Archive();			
		return archive;
	}
	
	public function OnLoad()
	{
		TeamInterface.SignalClientJoinedTeam.Connect(TeamJoin, this);
		TeamInterface.SignalClientLeftTeam.Connect(TeamLeave, this);
		TeamInterface.SignalClientJoinedRaid.Connect(TeamJoin, this);
		TeamInterface.SignalClientLeftRaid.Connect(TeamLeave, this);
	}
	
	function TeamJoin()
	{
		com.GameInterface.Input.RegisterHotkey(_global.Enums.InputCommand.e_InputCommand_Target_FriendlyNext, "com.xeio.TargetLowest.HotkeyManager.ToggleFriendlyTarget", _global.Enums.Hotkey.eHotkeyDown, 0); 
	}
	
	function TeamLeave()
	{
		com.GameInterface.Input.RegisterHotkey(_global.Enums.InputCommand.e_InputCommand_Target_FriendlyNext, "", _global.Enums.Hotkey.eHotkeyDown, 0);
	}
}