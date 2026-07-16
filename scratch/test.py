from youtube_transcript_api import YouTubeTranscriptApi

try:
    video_id = "GzHfE50N8x4"
    api = YouTubeTranscriptApi()
    print("Fetching...")
    res = api.fetch(video_id, languages=['zh-TW', 'zh-CN', 'zh', 'en'])
    print("Result type:", type(res))
    print("Attributes of result:", dir(res))
    
    # Let's inspect res.data or check if it's iterable
    # Often res.data contains the list of dictionaries or res itself is iterable or has a method.
    # Let's write a test script to print it
    # We can print res or res.snippet or iterate
    # Let's check if it's iterable
    try:
        iterator = iter(res)
        print("Result is iterable!")
        # Let's print first 3 items
        for i, item in enumerate(iterator):
            print(f"Item {i}: {item}")
            if i >= 3:
                break
    except TypeError:
        print("Result is NOT iterable")
except Exception as e:
    print("Error:", e)
