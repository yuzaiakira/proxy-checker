#!/bin/bash

# Config file path
CONFIG_FILE="$HOME/.proxy-checker.conf"

# Default values
PROXY_HOST="127.0.0.1"
PROXY_PORT="10808"
PROXY_TYPE="socks5h"
RESET_ONLY=false
STATUS_ONLY=false
DEBUG=false
SAVE_CONFIG=false

# Show help message
show_help() {
    echo "🛠️  Usage: proxy-checker [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --host <host>      Set proxy host (default: 127.0.0.1)"
    echo "  --port <port>      Set proxy port (default: 10808)"
    echo "  --type <type>      Set proxy type: socks5, socks5h, http, https (default: socks5h)"
    echo "  -s, --save         Save current configuration as default"
    echo "  --reset            Unset all proxy environment variables only"
    echo "  --status           Just show proxy status, no env changes"
    echo "  --debug            Show detailed logs"
    echo "  -h, --help         Show this help message"
    echo ""
    echo "Examples:"
    echo "  proxy-checker --host 192.168.0.1 --port 9050 -s"
    echo "  proxy-checker --status"
    echo "  proxy-checker --reset"
}

# Load config from file if exists
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

# Unset proxy environment variables
unset_proxy_vars() {
    unset all_proxy
    unset http_proxy
    unset https_proxy
    echo "🚫 Proxy environment variables unset."
}

# Set proxy environment variables
set_proxy_vars() {
    case "$PROXY_TYPE" in
        socks5|socks5h)
            export all_proxy="${PROXY_TYPE}://${PROXY_HOST}:${PROXY_PORT}"
            ;;
    esac
    export http_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
    export https_proxy="http://${PROXY_HOST}:${PROXY_PORT}"
    echo "🌐 Proxy environment variables set with type $PROXY_TYPE."
}

# Check proxy connection status
check_proxy_status() {
    if nc -z "$PROXY_HOST" "$PROXY_PORT"; then
        echo "✅ Proxy is running on $PROXY_HOST:$PROXY_PORT"
        return 0
    else
        echo "❌ Proxy is NOT running on $PROXY_HOST:$PROXY_PORT"
        return 1
    fi
}

# Save current config to file
save_config() {
    cat <<EOF > "$CONFIG_FILE"
PROXY_HOST="$PROXY_HOST"
PROXY_PORT="$PROXY_PORT"
PROXY_TYPE="$PROXY_TYPE"
EOF
    echo "💾 Configuration saved to $CONFIG_FILE"
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case "$1" in
        --host)
            PROXY_HOST="$2"
            shift 2
            ;;
        --port)
            PROXY_PORT="$2"
            shift 2
            ;;
        --type)
            PROXY_TYPE="$2"
            shift 2
            ;;
        --reset)
            RESET_ONLY=true
            shift
            ;;
        --status)
            STATUS_ONLY=true
            shift
            ;;
        --debug)
            DEBUG=true
            shift
            ;;
        -s|--save)
            SAVE_CONFIG=true
            shift
            ;;
        -h|--help)
            show_help
            return 0
            ;;
        *)
            echo "❗ Unknown parameter: $1"
            echo "Use -h or --help for usage."
            return 1
            ;;
    esac
done

# Show debug info if requested
if [ "$DEBUG" = true ]; then
    echo "🔍 Debug Info:"
    echo "  Host: $PROXY_HOST"
    echo "  Port: $PROXY_PORT"
    echo "  Type: $PROXY_TYPE"
    echo "  Reset Only: $RESET_ONLY"
    echo "  Status Only: $STATUS_ONLY"
    echo "  Save Config: $SAVE_CONFIG"
    echo ""
fi

# Save configuration if requested
if [ "$SAVE_CONFIG" = true ]; then
    save_config
fi

# If reset only, unset vars and exit
if [ "$RESET_ONLY" = true ]; then
    unset_proxy_vars
    return 0
fi

# If status only, just show status and exit
if [ "$STATUS_ONLY" = true ]; then
    check_proxy_status
    return 0
fi

# Normal operation: check proxy and set or unset vars
if check_proxy_status; then
    set_proxy_vars
else
    unset_proxy_vars
fi
