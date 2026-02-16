# Telegram Message Settings

## Link Preview Disabling

When sending messages to Telegram, use this parameter to disable link previews:

```
link_preview_options: {
  is_disabled: true
}
```

**Implementation:**
- Manual sends: Use `message` tool with `disableLinkPreview: true` or equivalent parameter
- Auto-sends (cron jobs): Need to configure delivery settings or post-process message

**Status:** Currently setting up for morning digest delivery. When I send the digest to Telegram at 7 AM, I will use the link preview disabling parameter to prevent thumbnails from showing.

---

## Telegram Formatting Rules

- **Links:** Wrap in angle brackets `<URL>` for cleaner appearance
- **Link Previews:** Disable via API parameter
- **Markdown:** Supported (bold, italic, code blocks, links)
- **Message Limits:** 4096 characters per message (will split if needed)
