from youtube_transcript_api import YouTubeTranscriptApi

try:
    video_id = "GzHfE50N8x4"
    api = YouTubeTranscriptApi()
    print("Fetching transcript...")
    res = api.fetch(video_id, languages=['zh-TW', 'zh-CN', 'zh', 'en'])
    
    with open("transcript.txt", "w", encoding="utf-8") as f:
        for entry in res:
            f.write(f"[{entry.start:.2f}] {entry.text}\n")
            
    print("Transcript written to transcript.txt successfully!")
except Exception as e:
    print("Error fetching transcript:", e)
