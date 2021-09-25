class_name Dialogues
extends Node


class StatesLog:
	var scenario
	var position
	var label
	var animation
	var blockname
	var character
	
	func _init(
		text_label: RichTextLabel,
		animation: AnimationPlayer,
		names: Dictionary,
		actors: Dictionary
	):
		self.label = text_label
		self.animation = animation
		self.blockname = names
		self.character = actors
		
	func run(
		scenario: Dictionary,
		scene: String
	):
		self.scenario = scenario[scene]
		self.position = 0
		
		var _text = self.scenario[self.position]
		
		if _text == "*start*":
			self.next()
	
	
	func next():
		if self.animation.current_animation == "text":
			self.skip_animation()
			
		else:
			var _position = self.position + 1
			var _text = self.scenario[_position]
			
			self.clear_block_name()
			
			if typeof(_text) == TYPE_ARRAY:
				var _scene_act = _text[1]
				
				var _block = _scene_act.keys()[0]
				var _actor = _scene_act[_block]
				
				var _character_name   = self.character[_actor]["name"]
				var _character_visual = self.character[_actor]["scene"]
				
				self.set_actor_name(
					_block, _character_name
				)
				
				self.set_actor_visual(
					_block, _character_visual
				)
				_text = _text[0]
			
			self.play_text(_text)
			self.position = _position
	
	
	func play_text(data):
		self.label.text = data
		self.animation.play("text")
	
	
	func skip_animation():
		self.animation.seek(1.1, true)
	
	
	func set_actor_visual(block, data):
		var exists = false
		var _block = self.blockname[block][1]
		var _instance = data.instance()
		
		for item in _block.get_children():
			if item.name == _instance.name:
				exists = true
				break
		
		if !exists:
			_block.add_child(_instance)
	
	
	func set_actor_name(block, data):
		var _block = self.blockname[block][0]
		var _block_label = _block.get_child(1)
		
		_block_label.text = data
		_block.visible = true
	
	
	func clear_block_name():
		for item in self.blockname:
			if self.blockname[item][0].visible:
				self.blockname[item][0].visible = false
