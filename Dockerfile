# Coinbell's MCP server is hosted at https://coinbell.org/mcp. This image exposes it as a local (stdio) MCP server
# through mcp-remote, for apps that can only start local servers. Set COINBELL_API_KEY to use the tools;
# without it you can still connect and list them.
FROM node:22-alpine
RUN npm install -g mcp-remote
ENV COINBELL_API_KEY=""
CMD ["sh", "-c", "if [ -n \"$COINBELL_API_KEY\" ]; then exec mcp-remote https://coinbell.org/mcp --transport http-only --header \"Authorization: Bearer $COINBELL_API_KEY\"; else exec mcp-remote https://coinbell.org/mcp --transport http-only; fi"]
