extends Node

@export var warrior_state_machine : WarriorStateMachine

func _on_attack_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group(GlobalGroup.PlayerGroup):
		warrior_state_machine.transition_to("attack")


func _on_attack_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group(GlobalGroup.PlayerGroup):
		warrior_state_machine.transition_to("idle")
