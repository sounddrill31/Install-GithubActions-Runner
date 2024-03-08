#!/bin/bash

# Parse command line argument
case $1 in
    --kill)
        echo "Stopping the runner..."
        tmux kill-session -t actions
        echo "Runner stopped."
        ;;
    --restart)
            tmux kill-session -t actions;
            tmux new-session -d -s actions
            tmux send-keys -t actions 'bash ~/actions-runner/run.sh' Enter
            echo "Runner Restarted"
        ;;
    *)
        if tmux has-session -t actions;
        then
            echo "Bot is already Running"
        else
            tmux new-session -d -s actions
            tmux send-keys -t actions 'bash ~/actions-runner/run.sh' Enter
            echo "Runner Started"
        fi
        ;;
esac