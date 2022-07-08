enum  StreamType{
  a
}

class StreamEntity{
   int uid;
   String url;
   String tile;
   String streamType;
   int duration;
   String uploader;
   String uploaderUrl;
   int viewCount;
   String textualUploadDate;
   int uploadDate;

   StreamEntity(
      this.uid,
      this.url,
      this.tile,
      this.streamType,
      this.duration,
      this.uploader,
      this.uploaderUrl,
      this.viewCount,
       this.textualUploadDate,
      this.uploadDate);
}