export const NotificationPlugin = async ({ $ }) => {
  let sessionWorkspace = null

  const getActiveWorkspace = async () => {
    try {
      const output = await $`hyprctl activeworkspace`.text()
      const match = output.match(/workspace ID\s+(\S+)/)

      if (match) {
        return match[1]
      }
    } catch {}

    return "unknown"
  }

  const sendWorkspaceNotification = async (message, workspace) => {
    try {
      const action = await $`notify-send -a OpenCode -A jump=Jump "OpenCode" "${message}"`.text()

      if (["jump", "default"].includes(action.trim()) && workspace !== "unknown") {
        await $`hyprctl dispatch focusworkspaceoncurrentmonitor ${workspace}`
      }
    } catch {
      await $`notify-send -a OpenCode "OpenCode" "${message}"`
    }
  }

  const getSessionWorkspace = async () => {
    return sessionWorkspace ?? (await getActiveWorkspace())
  }

  return {
    event: async ({ event }) => {
      if (
        !sessionWorkspace &&
        ["session.created", "session.updated", "message.updated", "command.executed"].includes(event.type)
      ) {
        sessionWorkspace = await getActiveWorkspace()
      }

      if (event.type === "session.idle") {
        const workspace = await getSessionWorkspace()
        await sendWorkspaceNotification(`Session completed on workspace ${workspace}`, workspace)
        sessionWorkspace = null
      }

      if (event.type === "session.error") {
        const workspace = await getSessionWorkspace()
        await sendWorkspaceNotification(`Session error on workspace ${workspace}`, workspace)
        sessionWorkspace = null
      }

      if (event.type === "permission.asked") {
        const workspace = await getSessionWorkspace()
        await sendWorkspaceNotification(`Permission needed on workspace ${workspace}`, workspace)
      }

      if (event.type === "session.deleted") {
        sessionWorkspace = null
      }
    },
  }
}
