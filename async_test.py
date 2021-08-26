import asyncio

async def get_chat_id(name):
    await asyncio.sleep(3)
    return "chat-%s" % name

async def main():
    result = await get_chat_id("django")
    print(result)

loop = asyncio.get_event_loop()
loop.run_until_complete(main())
loop.close()
