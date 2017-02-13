const_value set 2
	const ROUTE18WEST_BIKER

Route18West_MapScriptHeader:
.MapTriggers:
	db 1

	; triggers
	maptrigger .Trigger0

.MapCallbacks:
	db 1

	; callbacks

	dbw MAPCALLBACK_NEWMAP, .AlwaysOnBike

.Trigger0:
	end

.AlwaysOnBike:
	setflag ENGINE_ALWAYS_ON_BIKE
	return

Route18WestBikeCheckScript:
	callasm CheckPlayerState
	if_equal PLAYER_BIKE, .done
	opentext
	writetext Route18WestBikeWarningText
	waitbutton
	closetext
	applymovement PLAYER, Route18WestStepDownMovementData
.done
	end

TrainerBikerCharles:
	trainer EVENT_BEAT_BIKER_CHARLES, BIKER, CHARLES, BikerCharlesSeenText, BikerCharlesBeatenText, 0, BikerCharlesScript

BikerCharlesScript:
	end_if_just_battled
	opentext
	writetext UnknownText_0x1ad293
	waitbutton
	closetext
	end

Route18WestStepDownMovementData:
	step_down
	step_end

BikerCharlesSeenText:
	text "We're fearless"
	line "highway stars!"
	done

BikerCharlesBeatenText:
	text "Arrrgh! Crash and"
	line "burn!"
	done

UnknownText_0x1ad293:
	text "Reckless driving"
	line "causes accidents!"
	cont "Take it easy!"
	done

Route18WestBikeWarningText:
	text "You have to be on"
	line "a Bicycle to go"
	cont "on Cycling Road!"
	done

Route18West_MapEventHeader:
	; filler
	db 0, 0

.Warps:
	db 2
	warp_def $6, $13, 1, ROUTE_18_GATE
	warp_def $7, $13, 2, ROUTE_18_GATE

.XYTriggers:
	db 1
	xy_trigger 0, $0, $c, $0, Route18WestBikeCheckScript, $0, $0

.Signposts:
	db 0

.PersonEvents:
	db 1
	person_event SPRITE_BIKER, 2, 6, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_TRAINER, 4, TrainerBikerCharles, -1

CheckPlayerState:
	ld a, [PlayerState]
	ld [ScriptVar], a
	ret
