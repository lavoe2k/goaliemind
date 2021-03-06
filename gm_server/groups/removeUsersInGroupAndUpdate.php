<?php

require_once '../dbconfig.php';

include_once 'class.group.php';

if(isset($_GET['login']))
{
	//$uid = trim($_GET['uid']);
	$uname = trim($_GET['uname']);
	$umail = trim($_GET['email']);
	$upass = trim($_GET['pw']);
	$groupId = trim($_GET['groupId']);
	$groupName = trim($_GET['groupName']);
	$groupDescription = trim($_GET['groupDescription']);
	if(isset($_GET['groupUsers'])) $groupUsers = json_decode($_GET["groupUsers"], true);
	else $groupUsers = null;
	
	if($user->login($uname,$umail,$upass))
	{
		$group = new GROUP($DB_con);
		
		$removeGroupInfo['groupId'] = $groupId;
		
		$removeGroup = $group->removeUsersInGroup($removeGroupInfo);
		
		if ($removeGroup["result"] == true)
		{
			// $response["OK"] = "Your group has been removed.";
			
			// Now add updated users to group
			
			// var_dump($groupUsers);
			// echo "Going to Update Group Now";
			
			$newGroup = $group->updateGroupAndAddUsers($groupId, $groupName, $groupDescription, $groupUsers);
		
			if ($newGroup["result"] == true)
			{
				$response["OK"] = "Your group has been updated.";
			} 
			else $response["ERROR"] = "An error has occurred when updating your group. Please try again.";
		} 
		else $response["ERROR"] = "An error has occurred when updating the group. Please try again.";
		
		echo json_encode($response);
	}
	else
	{
		// Error when authenticating user
		if (!$error) $error[] = "Wrong Details!";
		$response["ERROR"] = $error;
		echo json_encode($response);
	}	
}

?>