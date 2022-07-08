class SubscriptionEntity {
  int id;
  String url;
  String name;
  String avatarUrl;
  int subcriberCount;
  String description;
  bool notificationMode;

  SubscriptionEntity(this.id, this.url, this.name, this.avatarUrl,
      this.subcriberCount, this.description, this.notificationMode);
}
