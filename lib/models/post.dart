

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String userIcon;
  final String caption;
  final DateTime postDate;
  final int likesCount;
  final int commentsCount;
  final int relayCount;
  final int shareCount;
  final int buyCount;
  final List<String> mediaUrls;
  final double price;
  final int stock;

  Post( {
    required this.userIcon,
    required this.caption,
    required this.postDate,
    required this.likesCount,
    required this.commentsCount,
    required this.relayCount,
    required this.shareCount,
    required this.buyCount,
    required this.mediaUrls,
    required this.price,
    required this.stock,
  });

  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'commentsCount': commentsCount,
      'likesCount': likesCount,
      'mediaUrls': mediaUrls,
      'postDate': postDate,
      'buyCount': buyCount,
      'relayCount': relayCount,
      'shareCount': shareCount,
      'userIcon': userIcon,
      'price': price,
      'stock': stock,
    };
  }

  static Post fromMap(Map<String, dynamic> map) {
    return Post(
      caption: map['caption'],
      commentsCount: map['commentsCount'],
      likesCount: map['likesCount'],
      mediaUrls: List<String>.from(map['mediaUrls']),
      postDate: map['postDate'],
      buyCount: map['buyCount'],
      relayCount: map['relayCount'],
      shareCount: map['shareCount'],
      userIcon: map['userIcon'],
      price: map['price'],
      stock: map['stock'],
    );
  }
}

// ... [Your previous Post model code]

extension PostFirestore on Post {
  static Post fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return Post(
      userIcon: data['userIcon'] ?? '',
      caption: data['caption'] ?? '',
      postDate: (data['postDate'] as Timestamp).toDate(),
      likesCount: data['likesCount'] ?? 0,
      commentsCount: data['commentsCount'] ?? 0,
      relayCount: data['relayCount'] ?? 0,
      shareCount: data['shareCount'] ?? 0,
      buyCount: data['purchaseCount'] ?? 0,
      mediaUrls: List<String>.from(data['mediaUrls'] ?? []),
      price: data['price'] ?? 0,
      stock: data['stock'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'userIcon': userIcon,
      'caption': caption,
      'postDate': postDate,
      'likesCount': likesCount,
      'commentsCount': commentsCount,
      'relayCount': relayCount,
      'shareCount': shareCount,
      'buyCount': buyCount,
      'mediaUrls': mediaUrls,
      'price': price,
      'stock': stock,
    };
  }
}

