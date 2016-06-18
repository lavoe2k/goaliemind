package goaliemind.view.home.overlays.settings 
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.renderers.DefaultListItemRenderer;
	import feathers.controls.renderers.IListItemRenderer;
	import feathers.data.ListCollection;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;

	import starling.display.DisplayObject;
	import starling.events.Event;
	
	import goaliemind.ui.base.HomePanelScreen;
	import goaliemind.core.AppNavigator;
	import goaliemind.system.LogUtil;

	/**
	 * ...
	 * @author Rafael Alvarado Emmanuelli
	 * RAID - Rafael Alvarado Indie Development
	 * (c) 2015
	 */
	public class SettingsHome extends HomePanelScreen
	{
		private var _list:List;
		
		public function SettingsHome() 
		{
			super();
		}
		
		override protected function initialize():void 
		{
			super.initialize();
			
			this.layout = new AnchorLayout();
			
			this.title = "Settings";
			
			this.headerFactory = this.customHeaderFactory;
			
			createList();
		}
		
		private function customHeaderFactory():Header
		{
			var header:Header = new Header();

			header.styleNameList.add(GlobalSettings.HOME_MAINHEADER);
			
			var backButton:Button = new Button();
			backButton.styleNameList.add(GlobalSettings.MAINHEADER_BUTTON);
			backButton.defaultIcon = _manager.appCore.assets.imageLoaderFactory("header/back_header_icon", _manager.appCore.theme.scale);
			
			header.leftItems = new <DisplayObject> [ backButton ];
			
			backButton.addEventListener(Event.TRIGGERED, onBackButton);
			
			return header;
		}		

		private function onBackButton(e:Event):void 
		{
			LogUtil.log("SettingsHome.onBackButton()");
			
			this.dispatchEventWith(AppNavigator.CLOSEPANEL);
		}		
		
		private function createList():void
		{
			var items:Array = [];
			items[items.length] = { label:"(c) 2015 | GoalieMind LLC | v1.02", isEnabled:false, icon:null, eventName:"account" };
			items[items.length] = { label:"Logout", isEnabled:true, icon:null, eventName:"logout" };
			items.fixed = true;
			
			var listLayoutData:AnchorLayoutData = new AnchorLayoutData(0, 0, 0, 0);
			
			_list = new List();
			_list.layoutData = listLayoutData;
			_list.dataProvider = new ListCollection(items);
			_list.styleNameList.add(GlobalSettings.OVERLAYPANELLIST);
			
			this._list.itemRendererFactory = function():IListItemRenderer
			{
				var renderer:DefaultListItemRenderer = new DefaultListItemRenderer();
				renderer.styleNameList.add(GlobalSettings.SETTINGSLISTITEM);
				renderer.itemHasEnabled = true;
				
				renderer.enabledFunction = function( item:Object ):Boolean
				{
					return item.isEnabled;
				};
				return renderer;
			}
			
			this.addChild(_list);
			
			_list.addEventListener(Event.CHANGE, onListChange);
		}		
		
		private function onListChange(e:Event):void 
		{
			LogUtil.log("SettingsScreen.onListChange() " + _list.selectedIndex);
			
			if (_list.selectedIndex == -1) return;
			
			if (_list.selectedItem.label == "Logout")
			{
				manager.logOut(onLogoutComplete); 
			}
			
			_list.selectedIndex = -1;
		}
		
		private function onLogoutComplete():void
		{
			
			
			
		}		
		
	}

}