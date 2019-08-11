@class QLTopicInfoLiteItemView,QLTopicInfoLiteComposite;

%hook QLTopicInfoLiteItemCell
- (void)setRightView:(QLTopicInfoLiteItemView *)rightView { %log; %orig; }
- (QLTopicInfoLiteItemView *)rightView { %log; QLTopicInfoLiteItemView * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setLeftView:(QLTopicInfoLiteItemView *)leftView { %log; %orig; }
- (QLTopicInfoLiteItemView *)leftView { %log; QLTopicInfoLiteItemView * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setTopicCom:(QLTopicInfoLiteComposite *)topicCom { %log; %orig; }
- (QLTopicInfoLiteComposite *)topicCom { %log; QLTopicInfoLiteComposite * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void)setViewCtlDelegate:(__weak id <QLTopicInfoLiteItemCellDelegate> )viewCtlDelegate { %log; %orig; }
- (__weak id <QLTopicInfoLiteItemCellDelegate> )viewCtlDelegate { %log; __weak id <QLTopicInfoLiteItemCellDelegate>  r = %orig; HBLogDebug(@" = 0x%x", (unsigned int)r); return r; }
- (void)setThemeColor:(UIColor *)themeColor { %log; %orig; }
- (UIColor *)themeColor { %log; UIColor * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (void).cxx_destruct { %log; %orig; }
- (void)reportShowUp { %log; %orig; }
- (void)QLTopicInfoLiteItemView:(id)arg1 tapAction:(id)arg2 { %log; %orig; }
- (void)layoutSubviews { %log; %orig; }
- (void)setObject:(id)arg1 { %log; %orig; }
- (id)initWithStyle:(long long)arg1 reuseIdentifier:(id)arg2 { %log; id r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString *)debugDescription { %log; NSString * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (NSString *)description { %log; NSString * r = %orig; HBLogDebug(@" = %@", r); return r; }
- (unsigned long long )hash { %log; unsigned long long  r = %orig; HBLogDebug(@" = %llu", r); return r; }
- (Class )superclass { %log; Class  r = %orig; HBLogDebug(@" = %@", r); return r; }
%end
