using Godot;
using System;

public partial class Boss : CharacterBody2D
{
	[Export] public float Speed = 250.0f;
	[Export] public float JumpVelocity = -400.0f;
	[Export] public int MaxHearts = 5;
	[Export] public float InitialActionInterval = 3.0f; // seconds between actions
	[Export] public float MinActionInterval = 1.0f;     // minimum interval
	[Export] public float IntervalDecreaseRate = 0.1f;  // per action

	private int currentHearts;
	private float actionTimer = 0f;
	private float currentInterval;
	private bool doJumpNext = true;

	private AnimatedSprite2D sprite;
	private Node2D player;

	public override void _Ready()
	{
		sprite = GetNode<AnimatedSprite2D>("bossSprite");
		sprite.Play("default");

		player = GetTree().Root.GetNode<Node2D>("Game/Player");
		currentHearts = MaxHearts;
		currentInterval = InitialActionInterval;
	}

	public override void _PhysicsProcess(double delta)
	{
		if (player == null) return;

		actionTimer += (float)delta;

		if (actionTimer >= currentInterval)
		{
			actionTimer = 0f;
			if (doJumpNext)
				JumpToPlayer();
			else
				RollTowardPlayer();

			doJumpNext = !doJumpNext;

			// Make the boss more aggressive over time
			currentInterval = Mathf.Max(MinActionInterval, currentInterval - IntervalDecreaseRate);
		}

		MoveAndSlide();
	}

	private void JumpToPlayer()
	{
		if (player == null) return;
		Vector2 targetPos = player.GlobalPosition;
		Vector2 dist = this.GlobalPosition - targetPos;
		if (!(516.0f < targetPos.X && targetPos.X < 756.0f && targetPos.Y < 20.0f))
			return;
		Vector2 dir = (targetPos - GlobalPosition).Normalized();
		Velocity = new Vector2(dir.X * Speed, JumpVelocity);
		sprite.Play("jump");
	}

	private void RollTowardPlayer()
	{
		if (player == null) return;
		Vector2 dir = (player.GlobalPosition - GlobalPosition).Normalized();
		Velocity = new Vector2(dir.X * Speed, 0);
		sprite.Play("roll");
	}

	public void OnHitByBullet()
	{
		currentHearts -= 1;
		GD.Print($"Boss hit! Hearts left: {currentHearts}");

		if (currentHearts <= 0)
			Die();
	}

	private void Die()
	{
		// sprite.Play("die");
		QueueFree();
	}

	private void _on_Boss_body_entered(Node body)
	{
		if (body.GetInstanceId() == player.GetInstanceId())
		{
			player.Call("lose_heart");
		}
	}
}
