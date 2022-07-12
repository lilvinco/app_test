import 'package:collection/collection.dart';

class ProductReleaseLinks {
  int? status;
  String? linkSite;
  String? linkSiteLink;
  String? linkSiteSlug;
  List<ShopLink?>? shopLinks;
  SocialLinks? socialLinks;

  ProductReleaseLinks({
    this.status,
    this.linkSite,
    this.linkSiteLink,
    this.linkSiteSlug,
    this.shopLinks,
    this.socialLinks,
  });

  ProductReleaseLinks copyWith({
    int? status,
    String? linkSite,
    String? linkSiteLink,
    String? linkSiteSlug,
    List<ShopLink>? shopLinks,
    SocialLinks? socialLinks,
  }) {
    return ProductReleaseLinks(
      status: status ?? this.status,
      linkSite: linkSite ?? this.linkSite,
      linkSiteLink: linkSiteLink ?? this.linkSiteLink,
      linkSiteSlug: linkSiteSlug ?? this.linkSiteSlug,
      shopLinks: shopLinks ??
          List.from(
              (this.shopLinks ?? []).map((e) => ShopLink.copy(e!)).toList()),
      socialLinks: (socialLinks ?? this.socialLinks)!.copyFrom(),
    );
  }

  ProductReleaseLinks.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    linkSite = json['link_site'] ?? "";
    linkSiteLink = json['link_site_link'] ?? "";
    linkSiteSlug = json['link_site_slug'] ?? "";
    if (json['shop_links'] != null) {
      shopLinks = <ShopLink?>[];
      json['shop_links'].forEach((v) {
        shopLinks!.add(ShopLink.fromJson(v));
      });
    }
    socialLinks = json['social_links'] != null
        ? SocialLinks.fromJson(json['social_links'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['link_site'] = linkSite;
    data['link_site_link'] = linkSiteLink;
    data['link_site_slug'] = linkSiteSlug;
    if (shopLinks != null) {
      data['shop_links'] =
          shopLinks!.map((ShopLink? v) => v!.toJson()).toList();
    }
    if (socialLinks != null) {
      data['social_links'] = socialLinks!.toJson();
    }
    return data;
  }

  void updateSocialLinks() {
    socialLinks!.facebookLink =
        socialLinks!.socialLinks!['facebook_link']!.link;
    socialLinks!.twitterLink = socialLinks!.socialLinks!['twitter_link']!.link;
    socialLinks!.snapchatLink =
        socialLinks!.socialLinks!['snapchat_link']!.link;
    socialLinks!.instagramLink =
        socialLinks!.socialLinks!['instagram_link']!.link;
    socialLinks!.youtubeLink = socialLinks!.socialLinks!['youtube_link']!.link;
    socialLinks!.youtubeVideoLink =
        socialLinks!.socialLinks!['youtube_video_link']!.link;
  }

  @override
  bool operator ==(Object other) {
    Function deepEq = const DeepCollectionEquality.unordered().equals;
    return identical(this, other) ||
        other is ProductReleaseLinks &&
            runtimeType == other.runtimeType &&
            status == other.status &&
            linkSite == other.linkSite &&
            linkSiteLink == other.linkSiteLink &&
            linkSiteSlug == other.linkSiteSlug &&
            deepEq(shopLinks, other.shopLinks) &&
            socialLinks == other.socialLinks;
  }

  @override
  int get hashCode =>
      status.hashCode ^
      linkSite.hashCode ^
      linkSiteLink.hashCode ^
      linkSiteSlug.hashCode ^
      shopLinks.hashCode ^
      socialLinks.hashCode;
}

class ShopLink {
  String? idLinkSitePartner;
  String? idPartner;
  String? name;
  String? link;
  String? shortLink;
  int? order;
  int? showOnLinkSite;
  String? logoLink;

  ShopLink({
    this.idLinkSitePartner,
    this.idPartner,
    this.name,
    this.link,
    this.shortLink,
    this.order,
    this.showOnLinkSite,
    this.logoLink,
  });

  ShopLink.fromJson(Map<String, dynamic> json) {
    idLinkSitePartner = json['idLinkSitePartner'] ?? "";
    idPartner = json['idPartner'] ?? "";
    name = json['name'] ?? "";
    link = json['link'] ?? "";
    shortLink = json['short_link'] ?? "";
    order =
        json['order'] == null ? 0 : int.tryParse(json['order'].toString()) ?? 0;
    showOnLinkSite = json['show_on_link_site'] ?? "" as int?;
    logoLink = json['logo_link'] ?? "";
  }

  ShopLink.copy(ShopLink data) {
    idLinkSitePartner = data.idLinkSitePartner;
    idPartner = data.idPartner;
    name = data.name;
    link = data.link;
    shortLink = data.shortLink;
    order = data.order;
    showOnLinkSite = data.showOnLinkSite;
    logoLink = data.logoLink;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idLinkSitePartner'] = idLinkSitePartner;
    data['idPartner'] = idPartner;
    data['name'] = name;
    data['link'] = link;
    data['short_link'] = shortLink;
    data['order'] = order;
    data['show_on_link_site'] = showOnLinkSite;
    data['logo_link'] = logoLink;
    return data;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is ShopLink &&
            runtimeType == other.runtimeType &&
            idLinkSitePartner == other.idLinkSitePartner &&
            idPartner == other.idPartner &&
            name == other.name &&
            link == other.link &&
            shortLink == other.shortLink &&
            order == other.order &&
            showOnLinkSite == other.showOnLinkSite &&
            logoLink == other.logoLink;
  }

  @override
  int get hashCode =>
      idLinkSitePartner.hashCode ^
      idPartner.hashCode ^
      name.hashCode ^
      link.hashCode ^
      shortLink.hashCode ^
      order.hashCode ^
      showOnLinkSite.hashCode ^
      logoLink.hashCode;
}

class SocialLinks {
  String? facebookLink;
  String? twitterLink;
  String? snapchatLink;
  String? instagramLink;
  String? youtubeLink;
  String? youtubeVideoLink;

  Map<String, SocialLink>? socialLinks;

  SocialLinks({
    this.facebookLink,
    this.twitterLink,
    this.snapchatLink,
    this.instagramLink,
    this.youtubeVideoLink,
    this.youtubeLink,
    this.socialLinks,
  });

  SocialLinks copyFrom({
    String? facebookLink,
    String? twitterLink,
    String? snapchatLink,
    String? instagramLink,
    String? youtubeLink,
    String? youtubeVideoLink,
    Map<String, SocialLink>? socialLinks,
  }) {
    Map<String, SocialLink> clonedSocialLinks = {};

    if (socialLinks == null) {
      this
          .socialLinks!
          .forEach((key, value) => clonedSocialLinks[key] = value.copyFrom());
    }

    return SocialLinks(
      facebookLink: facebookLink ?? this.facebookLink,
      twitterLink: twitterLink ?? this.twitterLink,
      snapchatLink: snapchatLink ?? this.snapchatLink,
      instagramLink: instagramLink ?? this.instagramLink,
      youtubeVideoLink: youtubeVideoLink ?? this.youtubeVideoLink,
      youtubeLink: youtubeLink ?? this.youtubeLink,
      socialLinks: socialLinks ?? clonedSocialLinks,
    );
  }

  SocialLinks.fromJson(Map<String, dynamic> json) {
    socialLinks = {};

    facebookLink = json['facebook_link'] ?? '';
    twitterLink = json['twitter_link'] ?? "";
    snapchatLink = json['snapchat_link'] ?? "";
    instagramLink = json['instagram_link'] ?? "";
    youtubeLink = json['youtube_link'] ?? "";
    youtubeVideoLink = json['youtube_video_link'] ?? "";
    json.forEach((String key, item) {
      socialLinks![key] = SocialLink.fromJson({'name': key, 'link': item});
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['facebook_link'] = socialLinks!["facebook_link"]!.link;
    data['twitter_link'] = socialLinks!["twitter_link"]!.link;
    data['snapchat_link'] = socialLinks!["snapchat_link"]!.link;
    data['instagram_link'] = socialLinks!["instagram_link"]!.link;
    data['youtube_link'] = socialLinks!["youtube_link"]!.link;
    data['youtube_video_link'] = socialLinks!["youtube_video_link"]!.link;

    return data;
  }

  @override
  bool operator ==(Object other) {
    Function deepEq = const DeepCollectionEquality.unordered().equals;

    return identical(this, other) ||
        other is SocialLinks &&
            runtimeType == other.runtimeType &&
            facebookLink == other.facebookLink &&
            twitterLink == other.twitterLink &&
            snapchatLink == other.snapchatLink &&
            instagramLink == other.instagramLink &&
            youtubeLink == other.youtubeLink &&
            youtubeVideoLink == other.youtubeVideoLink &&
            deepEq(socialLinks, other.socialLinks);
  }

  @override
  int get hashCode =>
      facebookLink.hashCode ^
      twitterLink.hashCode ^
      snapchatLink.hashCode ^
      instagramLink.hashCode ^
      youtubeLink.hashCode ^
      youtubeVideoLink.hashCode ^
      socialLinks.hashCode;
}

class SocialLink {
  String? name;
  String? link;

  SocialLink({
    this.name,
    this.link,
  });

  SocialLink.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    link = json['link'] ?? "";
  }

  SocialLink copyFrom({
    String? name,
    String? link,
  }) {
    return SocialLink(
      name: name ?? this.name,
      link: link ?? this.link,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialLink &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          link == other.link;

  @override
  int get hashCode => name.hashCode ^ link.hashCode;
}
