# Pulumi wrapper to invalidate prompt cache after stack operations
function pulumi
  set -l pulumi_bin "$HOME/.pulumi/bin/pulumi"

  if not test -x "$pulumi_bin"
    printf "pulumi not found at %s\n" "$pulumi_bin" >&2
    return 127
  end

  $pulumi_bin $argv

  # Invalidate cache after stack-changing operations
  if set -q argv[1]; and contains -- $argv[1] stack select init
    set -e _pulumi_cache_key
    set -e _pulumi_cache_stack
  end
end
