# Coinbell MCP server

Live market data for AI assistants: crypto, stock, gold, oil and US dollar rates in 38 currencies, USDT P2P rates from Binance and Bybit, crypto news, whale transfers, an economic calendar, a scam-link checker and your own Coinbell price alerts.

Coinbell's MCP server is hosted, so there is nothing to install. Connect your AI app to:

```
https://coinbell.org/mcp
```

Transport: Streamable HTTP. Tool calls need a free API key from [coinbell.org/developers](https://coinbell.org/developers), sent as `Authorization: Bearer YOUR_KEY` (or `?key=YOUR_KEY` on the URL for apps that only take a URL). Connecting and listing the tools work without a key.

## Setup

**Claude (desktop and claude.ai):** Settings → Connectors → Add custom connector → `https://coinbell.org/mcp?key=YOUR_KEY`

**ChatGPT:** Settings → Apps & Connectors → Advanced → Developer mode → Create → paste `https://coinbell.org/mcp?key=YOUR_KEY`, "No authentication".

**Claude Code:**

```
claude mcp add --transport http coinbell https://coinbell.org/mcp --header "Authorization: Bearer YOUR_KEY"
```

**Cursor** (`~/.cursor/mcp.json`) and **VS Code** (`.vscode/mcp.json`):

```json
{
  "mcpServers": {
    "coinbell": {
      "url": "https://coinbell.org/mcp",
      "headers": { "Authorization": "Bearer YOUR_KEY" }
    }
  }
}
```

(In VS Code the top-level key is `"servers"` and each server also has `"type": "http"`.)

**Apps that only run local (stdio) servers:** run the included Docker image, which connects to the hosted server with [mcp-remote](https://www.npmjs.com/package/mcp-remote):

```
docker build -t coinbell-mcp .
docker run -i --rm -e COINBELL_API_KEY=YOUR_KEY coinbell-mcp
```

## Tools

| Tool | What it does |
| --- | --- |
| `get_crypto_price` | Price, 1h/24h/7d change, range, market cap and distance from the all-time high, in any of 38 currencies |
| `get_top_coins` | Top coins by market cap, or the biggest gainers and losers |
| `get_market_overview` | Total market cap, dominance and the Fear & Greed index |
| `get_gold_price` | Gold by karat (24K, 22K, 21K, 18K) and local units (tola, pavan…), plus silver |
| `get_oil_price` | Brent and WTI per barrel and per litre |
| `get_dollar_rate` | 1 US dollar in a currency today, with 30-day and 1-year change |
| `convert` | Between currencies, crypto, gold, oil and popular stocks |
| `get_stock_quote` | Stock, ETF or index quote by ticker or company name |
| `get_stock_market_overview` | World indices, the dollar index, bond yields and crypto stocks |
| `get_usdt_p2p_rate` | Best USDT P2P buy and sell rates on Binance and Bybit, and the premium over the bank rate |
| `get_crypto_news` | Latest headlines, optionally for one coin |
| `get_whale_transfers` | Large USDT/USDC transfers on Tron, Ethereum and BNB Chain |
| `get_economic_calendar` | Fed decisions, options expiries and the next Bitcoin halving |
| `check_link` | Checks a link for common crypto phishing tricks |
| `list_my_alerts`, `create_alert`, `delete_alert` | Manage your Coinbell price alerts (sent by Telegram, email or push) |

## Limits

Free key: 1,000 requests a day, 20 a minute. Pro and the API plan raise the limits ([pricing](https://coinbell.org/pricing#api)). Each tool call counts as one request.

## Links

- Docs: https://coinbell.org/developers#mcp
- Privacy: https://coinbell.org/privacy
- Terms: https://coinbell.org/terms

Prices are information, not financial advice.
