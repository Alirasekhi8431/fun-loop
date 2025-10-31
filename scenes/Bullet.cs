using Godot;
using System;

public partial class Bullet : CharacterBody2D
{
	public const float Speed = 160;

	public override void _Ready()
	{
		// this.TopLevel = true;
		this.CollisionLayer = 2;
		this.CollisionMask = 1;
	}


	public override void _PhysicsProcess(double delta)
	{
		Vector2 velocity = Velocity;

		// Add the gravity.
		// if (!IsOnFloor())
		// 	velocity += GetGravity() * (float)delta * 1e-3f;

		// // Handle Jump.
		// if (Input.IsActionJustPressed("ui_accept") && IsOnFloor())
		// {
		// 	velocity.Y = JumpVelocity;
		// }

		// Get the input direction and handle the movement/deceleration.
		// As good practice, you should replace UI actions with custom gameplay actions.
		velocity.X =  Math.Sign(Velocity.X) * (float)delta * Speed;


		Velocity = velocity;
		KinematicCollision2D collision = MoveAndCollide(velocity);
		if (collision != null)
		{
			GodotObject collider = collision.GetCollider();
			this.Free();
		}
	}
}
