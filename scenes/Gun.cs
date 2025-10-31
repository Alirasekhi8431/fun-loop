using Godot;
using System;

public partial class Gun : Node2D
{
	PackedScene bulletScene;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		bulletScene = GD.Load<PackedScene>("res://scenes/bullet.tscn");
	}

	// Called every frame. 'delta' is the elapsed time since the previous frame.
	public override void _Process(double delta)
	{
	}

	public override void _UnhandledKeyInput(InputEvent @event)
	{
		if (@event is InputEventKey keyEv)
		{
			if (keyEv.Pressed && !keyEv.Echo && keyEv.KeyLabel == Key.S)
			{
				GD.Print("shooting ...");
				CharacterBody2D newBullet = bulletScene.Instantiate<CharacterBody2D>();
				if ((bool)this.GetParent().GetMeta("isLeft") == true) // players direction
					newBullet.Velocity = new Vector2(-1, 0);
				else
					newBullet.Velocity = new Vector2(1, 0);
				this.AddChild(newBullet);
			}
		}
	}

}
