fQuest
	var
		internal_id = 0;
		internal_name = NULL;
		name = NULL; // Name of quest to be displayed
		desc = NULL; // A description of our quest to be delivered via the questlog.
		completedVariables[] = list()
		savedVariables[] = list() // Variables that are saved to the database to track player progress
		allowedRaces[] = list()
		allowedAlign[] = list()

fQuest_Factory
	parent_type = /Factory
	objectType = /fQuest

	proc
		/**
		completeCheck
		@Desc: Loops through all the players quests and see if they can be completed
		*/
		completeCheck(var/mob/m as mob);

		/**
		hasCompleted
		@Desc: This procedure determines if we have completed the quest variables or not.
		@param 1: quest name
		@param 2: mobile reference
		*/
		hasCompleted(var/quest as text, var/mob/m as mob);

		/**
		canComplete
		@Desc: This procedure determines if we can complete the quest.
		@param 1: quest name
		@param 2: quest data variables
		@param 3: mobile reference
		*/
		canComplete(var/quest as text, var/list/variables, var/mob/m as mob);

		/**
		getRewards
		@Desc: This procedure rewards the player for completing the quest.
		@param 1: quest name
		@param 2: mobile reference
		*/
		getRewards(var/quest as text, var/mob/m as mob);

		/**
		hasItem
		@Desc: This procedure checks if the mobile(@param 1) has the determine item type(@param 2) in their contents.
		@param 1: mobile reference
		@param 2: item type path
		*/
		hasItem(var/mob/m as mob, var/type);

		/**
		updateQuest
		@Desc: This procedure updates our mobiles(@param 1) quest data in the database.
		@param 1: mobile reference
		@param 2: quest name
		@param 3: quest data variables
		@param 4: completed quest boolean
		*/
		updateQuest(var/mob/m as mob, var/quest as text, var/list/variables, var/completed=FALSE);

		/**
		checkKill
		@Desc: This procedure checks if the user has a quest that has an objective to kill this mob this is called everytime you kill an NPC.
		@param 1: npc mobile reference
		@param 2: player mobile reference
		@param 3: player quest data variables
		*/
		checkKill(var/mob/NPA/m as mob, var/mob/Player/p as mob, var/list/variables);

		/**
		updateVariable
		@Desc: Update a players quest data varaible.
		@param 1: mobile reference
		@param 2: quest name
		@param 3: quest variable
		@param 4: quest value
		*/
		updateVariable(var/mob/m as mob, var/quest as text, var/questVar as text, var/questVal);

		/**
		awardItem
		@Desc: Awards an item to a player and sends them a message.
		@param 1: mobile reference
		@param 2: item type path
		@param 3: number of items if multiple default is 1
		*/
		awardItem(var/mob/m as mob, var/type, var/amount as num);

		/**
		obtainQuest
		@Desc: Gives a player a new quest if they haven't completed or obtained arleady.
		@param 1: mobile reference
		@param 2: quest name
		*/
		obtainQuest(var/mob/m as mob, var/quest as text);

		/**
		checkPower
		@Desc: Check all available quests to see if any of them have powerlevel requirements
		@param 1: mobile reference
		*/
		checkPower(var/mob/m as mob);

		/**
		checkSkill
		@Desc: Check all available quests to see if any of them have skill requirements
		@param 1: mobile reference
		*/
		checkSkill(var/mob/m as mob);

		/**
		isCompleted
		@Desc: Check if we completed a quest or not
		@param 1: mobile reference
		*/
		isCompleted(var/mob/m as mob, var/quest as text);

		/**
		printObjectives
		@Desc: This procedure will print out a list of objectives and if they're completed or not.
		@param 1: mobile reference
		@param 2: internal quest name
		@param 3: mobiles quest data
		*/
		printObjectives(var/mob/m as mob, var/quest as text, var/list/questVars);

		/**
		grabNPCName
		@Desc: This procedure will return a NPC's name for the quest log
		*/
		grabNPCName(var/request as text);

		/**
		grabItemName
		@Desc: This procedure will return an ITEM's display name for the quest log
		*/
		grabItemName(var/request as text);

		/**
		checkItem(var/mob/m as mob)
		@Desc: This procedure will check if we have an item quest this will be called upon adding a new item to your inventory.
		@param 1: mobile reference
		*/
		checkItem(var/mob/m as mob);

		/**
		grabSkillName
		@Desc: This procedure will return the SKILL's display name for the quest log
		*/
		grabSkillName(var/request as text);

		/**
		questCheck
		@Desc: This procedure will check if a player has any missing quests after completing a certain quest and will fix that.
		*/
		questCheck(var/mob/m as mob);