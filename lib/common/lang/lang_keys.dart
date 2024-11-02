part of 'my_lang.dart';

abstract class Lang {
  // 公共
  static const sendCode = 'send_code';
  static const send = 'send';
  static const album = 'album';
  static const save = 'save';
  static const confirm = 'confirm';
  static const confirmLater = 'confirm_later';
  static const goConfirm = 'go_confirm';
  static const cancel = 'cancel';
  static const noData = 'no_data';
  static const delete = 'delete';
  static const reply = 'reply';
  static const retry = 'retry';
  static const search = 'search';
  static const saveImageToGallery = 'save_image_to_gallery';
  static const saveImageToGalleryFailed = 'save_image_to_gallery_failed';
  static const saveImageToGallerySuccess = 'save_image_to_gallery_success';
  static const noStoragePermission = 'no_storage_permission';
  static const reset = 'reset';
  static const copy = 'copy';
  static const isContinue = 'continue';
  static const yes = 'yes';
  static const no = 'no';
  static const collectType = 'collect_type';
  static const realNameAlert = 'real_name_alert';
  static const goRealName = 'go_real_name';
  static const tryItNow = 'try_it_now';
  static const activityClosed = 'activity_closed';
  static const connecting = 'connecting';
  static const connectFailed = 'connect_failed';
  static const videoPlayerLoading = 'video_player_loading';
  static const fileSizeOut = 'file_size_out';

  static const languageEnglish = 'language_english';
  static const languageChinese = 'language_chinese';
  static const themeLight = 'theme_light';
  static const themeDark = 'theme_dark';
  static const themeSystem = 'theme_system';
  // static const tokenError = 'token_error';
  static const hideNoticeToday = 'hide_notice_today';
  static const free = 'free';
  static const free2 = 'free2';
  static const freeReady = 'free_ready';
  static const freeDone = 'free_done';

  // 输入框相关
  static const inputAccountHintText = 'input_account_hint_text';
  static const inputPasswordHintText = 'input_password_hint_text';
  static const inputRePasswordHintText = 'input_re_password_hint_text';
  static const inputCaptchaHintText = 'input_captcha_hint_text';
  static const inputCaptchaSendText = 'input_captcha_send_text';
  static const inputPhoneHintText = 'input_phone_hint_text';
  static const inputPhoneCodeHintText = 'input_phone_code_hint_text';
  static const inputSendSmsButtonText = 'input_send_sms_button_text';

  // 未知页面
  static const unknownViewTitle = 'unknown_view_title';

  // webView
  static const webViewTitle = 'web_view_title';

  // 扫码页面
  static const scanViewTitle = 'scan_view_title';
  static const scanViewMessage = 'scan_view_message';
  static const scanViewResult = 'scan_view_result';

  // 登录界面
  static const loginViewTitleLogin = 'login_view_title_login';
  static const loginViewTitleRegister = 'login_view_title_register';
  static const loginViewTitleForgotPassword = 'login_view_title_forget_password';
  static const loginViewRememberAccount = 'login_view_remember_account';
  static const loginViewLogin = 'login_view_login';
  static const loginViewGoBackLogin = 'login_view_go_back_login';
  static const loginViewRegister = 'login_view_register';
  static const loginViewLoginForPassword = 'login_view_login_for_password';
  static const loginViewLoginForCode = 'login_view_login_for_code';
  static const loginViewForgotPassword = 'login_view_forget_password';
  static const loginViewGetBackPassword = 'login_view_get_back_password';

  // 主页面
  static const bottomHome = 'bottom_home';
  static const bottomFlashExchange = 'bottom_flash_exchange';
  static const bottomScan = 'bottom_scan';
  static const bottomChat = 'bottom_chat';
  static const bottomMine = 'bottom_mine';

  // 首页
  static const homeViewUid = 'home_view_uid';
  static const homeViewBalance = 'home_view_balance';
  static const homeViewSelling = 'home_view_selling';
  static const homeViewLock = 'home_view_lock';
  static const homeViewWalletAddress = 'home_view_wallet_address';
  static const homeViewBuyCoin = 'home_view_buy_coin';
  static const homeViewSellCoin = 'home_view_sell_coin';
  static const homeViewTransfer = 'home_view_transfer';
  static const homeViewBuyOrders = 'home_view_buy_orders';
  static const homeViewSellOrders = 'home_view_sell_orders';
  static const homeViewQuickBuyButton = 'home_view_quick_buy_button';
  static const homeViewQuickBuyTitle = 'home_view_quick_buy_title';
  static const homeViewQuickBuyContent = 'home_view_quick_buy_content';

  static const faqTitle = 'faq_title';
  static const faqNormal = 'faq_normal';
  static const faqHot = 'faq_Hot';

  static const flashViewHistory = 'flash_view_history';
  static const flashViewExchangeRate = 'flash_view_exchange_rate';
  static const flashViewExchangeAmount = 'flash_view_exchange_amount';
  static const flashViewProtocolTitle = 'flash_view_protocol_title';
  static const flashViewProtocolChoose = 'flash_view_protocol_choose';
  static const flashViewProtocolAlert = 'flash_view_protocol_alert';
  static const flashViewProtocolTrc = 'flash_view_trc';
  static const flashViewProtocolErc = 'flash_view_erc';
  static const flashViewExchange = 'flash_view_exchange';
  static const flashViewCgb = 'flash_view_cgb';
  static const flashViewUsdt = 'flash_view_usdt';
  static const flashViewTitle = 'flash_view_title';
  static const flashViewCheckTitle = 'flash_view_check_title';
  static const flashViewCheckSure = 'flash_view_check_sure';
  static const flashViewCheckGet = 'flash_view_check_get';
  
  static const chatViewTitle = 'chat_view_title';
  static const chatViewNotifyTitle = 'chat_view_notify_title';
  static const chatViewNotifyContent = 'chat_view_notify_content';
  static const chatViewNotifyPersonalTitle = 'chat_view_notify_personal_title';
  static const chatViewNotifyPersonalContent = 'chat_view_notify_personal_content';
  static const chatViewCustomerTitle = 'chat_view_customer_title';
  static const chatViewCustomerContent = 'chat_view_customer_content';

  static const mineViewTutorialTitle = 'mine_view_tutorial_title';
  static const mineViewTutorialContent = 'mine_view_tutorial_content';
  static const mineViewWalletHistory = 'mine_view_wallet_history';
  static const mineViewPromotions = 'mine_view_promotions';
  static const mineViewAccount = 'mine_view_account';
  static const mineViewSafe = 'mine_view_safe';
  static const mineViewSystemNotify = 'mine_view_system_notify';
  static const mineViewFaq = 'mine_view_faq';
  static const mineViewVersion = 'mine_view_version';
  static const mineViewSettings = 'mine_view_settings';

  static const personalInfoViewTitle = 'personal_info_view_title';
  static const personalInfoViewAvatar = 'personal_info_view_avatar';
  static const personalInfoViewUID = 'personal_info_view_uid';
  static const personalInfoViewLastLoginTime = 'personal_info_view_last_login_time';
  static const personalInfoViewLastLoginIP = 'personal_info_view_last_login_ip';
  static const personalInfoViewNickName = 'personal_info_view_nick_name';
  static const personalInfoViewLogout = 'personal_info_view_logout';
  static const personalInfoViewLogoutAlert = 'personal_info_view_logout_alert';
  static const personalInfoViewAvatarTitle = 'personal_info_view_avatar_title';

  static const editNicknameViewTitle = 'edit_nickname_view_title';
  static const editNicknameViewHintText= 'edit_nickname_view_hint_text';
  static const editNicknameViewConfirm= 'edit_nickname_view_confirm';

  //钱包历史记录
  static const walletHistoryViewTitle = 'wallet_history_view_title';
  static const walletHistoryViewBalance = 'wallet_history_view_balance';
  static const walletHistoryViewLock = 'wallet_history_view_lock';
  static const walletHistoryViewSelling = 'wallet_history_view_selling';
  static const walletHistoryViewToday = 'wallet_history_view_today';
  static const walletHistoryViewMonth = 'wallet_history_view_month';
  static const walletHistoryViewTypeSelection = 'wallet_history_view_type_selection';

  static const promotionListViewTitle = 'promotion_list_view_title';
  static const promotionInfoViewTitle = 'promotion_info_view_title';

  static const settingsViewTitle = 'settings_view_title';
  static const settingsViewLanguage = 'settings_view_language';
  static const settingsViewTheme = 'settings_view_theme';
  static const settingsViewAudioAlert = 'settings_view_audio_alert';
  static const settingsViewShock = 'settings_view_shock';

  static const walletManagerViewTitle = 'wallet_manager_view_title';
  static const walletManagerViewAdd = 'wallet_manager_view_add';
  static const walletManagerViewDefault = 'wallet_manager_view_default';
  static const walletManagerViewDefaultSet = 'wallet_manager_view_default_set';
  static const walletManagerViewDefaultAlready = 'wallet_manager_view_default_already';
  static const walletManagerViewAddAccount = 'wallet_manager_view_add_account';
  static const walletManagerViewDeleteAlertTitle = 'wallet_manager_view_delete_alert_title';
  static const walletManagerViewDeleteAlertContent = 'wallet_manager_view_delete_alert_content';
  static const walletManagerViewSetDefaultAlertTitle = 'wallet_manager_view_set_default_alert_title';
  static const walletManagerViewSetDefaultAlertContent = 'wallet_manager_view_set_default_alert_content';

  static const refreshDone = 'refresh_done';
  static const refreshLoading = 'refresh_loading';
  static const refreshOnLoading = 'refresh_on_loading';
  static const refreshLoadingFailed = 'refresh_loading_failed';
  static const refreshLoadingDrop = 'refresh_loading_drop';
  static const refreshLoadingNoData = 'refresh_loading_no_data';

  static const walletAddViewTitle = 'wallet_add_view_title';
  static const walletAddViewName = 'wallet_add_view_name';
  static const walletAddViewNameHintText = 'wallet_add_view_name_hint_text';
  static const walletAddViewAccountType = 'wallet_add_view_account_type';
  static const walletAddViewBank = 'wallet_add_view_bank';
  static const walletAddViewBankHintText = 'wallet_add_view_bank_hint_text';
  static const walletAddViewBankName = 'wallet_add_view_bank_name';
  static const walletAddViewBankNameHintText = 'wallet_add_view_bank_name_hint_text';
  static const walletAddViewAlipayAccount = 'wallet_add_view_alipay_account';
  static const walletAddViewAlipayAccountHintText = 'wallet_add_view_alipay_account_hint_text';
  static const walletAddViewAddress = 'wallet_add_view_wallet_address';
  static const walletAddViewAddressHintText = 'wallet_add_view_wallet_address_hint_text';
  static const walletAddViewQrcode = 'wallet_add_view_qrcode';
  static const walletAddViewQrcodeUpload = 'wallet_add_view_qrcode_upload';
  static const networkErrorTitle = 'network_error_title';
  static const networkErrorContent = 'network_error_content';
  static const settingApiErrorTitle = 'setting_api_error_title';
  static const settingApiErrorContent = 'setting_api_error_content';
  static const settingWssErrorTitle = 'setting_wss_error_title';
  static const settingWssErrorContent = 'setting_wss_error_content';
  static const settingErrorTitle = 'setting_error_title';
  static const settingErrorContent = 'setting_error_content';
  static const bankViewTitle = 'bank_view_title';
  static const bankViewHintText = 'bank_view_hint_text';
  static const bankViewErrorText = 'bank_view_error_text';
  static const close = 'close';

  static const securityViewTitle = 'security_view_title';
  static const securityViewSignPassword = 'security_view_sign_password';
  static const securityViewRealName = 'security_view_real_name';
  static const securityViewRealNameCertified = 'security_view_real_name_certified';
  static const securityViewRealNameCertificationFailed = 'security_view_real_name_certification_failed';
  static const securityViewRealNameGoToCertification = 'security_view_real_name_go_to_certification';
  static const securityViewUserName = 'security_view_user_name';
  static const securityViewPhone = 'security_view_phone';
  static const securityViewPhoneAlert = 'security_view_phone_alert';
  static const securityViewWalletPassword = 'security_view_wallet_password';

  static const passwordSignViewTitle = 'password_sign_view_title';
  static const passwordSignViewSecondTitle = 'password_sign_view_second_title';
  static const passwordSignViewNewHintText = 'password_sign_view_new_hint_text';
  static const passwordSignViewRenewHintText = 'password_sign_view_renew_hint_text';
  static const passwordSignViewConfirm = 'password_sign_view_confirm';

  static const walletPasswordViewTitleSet = 'wallet_password_view_title_set';
  static const walletPasswordViewTitleReset = 'wallet_password_view_title_reset';
  static const walletPasswordViewOld = 'wallet_password_view_old';
  static const walletPasswordViewNew = 'wallet_password_view_new';
  static const walletPasswordViewRenew = 'wallet_password_view_renew';
  static const walletPasswordViewConfirm = 'wallet_password_view_confirm';

  static const versionViewTitle = 'version_view_title';
  static const versionViewVersion = 'version_view_version';
  static const versionViewCheck = 'version_view_check';
  static const versionViewSnackContent = 'version_view_snack_content';
  static const versionViewBottom = 'version_view_bottom';
  static const versionViewAlertTitle = 'version_view_alert_title';
  static const versionViewAlertContent = 'version_view_alert_content';
  static const versionViewAlertNow = 'version_view_alert_now';
  static const versionViewAlertLater = 'version_view_alert_later';

  static const notifyViewTitleSystem = 'notify_view_title_system';
  static const notifyViewTitlePersonal = 'notify_view_title_personal';
  static const notifyViewMore = 'notify_view_more';

  static const realNameViewTitle = 'real_name_view_title';
  static const realNameViewName = 'real_name_view_name';
  static const realNameViewNameHintText = 'real_name_view_name_hint_text';
  static const realNameViewNameFailed = 'real_name_view_name_failed';
  static const realNameViewID = 'real_name_view_id';
  static const realNameViewIDHintText = 'real_name_view_id_hint_text';
  static const realNameViewIDFailed = 'real_name_view_id_failed';
  static const realNameViewNext = 'real_name_view_next';
  static const realNameViewNoticeTitle = 'real_name_view_notice_title';
  static const realNameViewNoticeContent = 'real_name_view_notice_content';
  static const realNameViewNoticeIDFrontTitle = 'real_name_view_id_front_title';
  static const realNameViewNoticeIDFrontContent = 'real_name_view_id_front_content';
  static const realNameViewNoticeIDBackTitle = 'real_name_view_id_back_title';
  static const realNameViewNoticeIDBackContent = 'real_name_view_id_back_content';
  static const realNameViewConfirmID = 'real_name_view_confirm_id';
  static const realNameViewUploadAgain = 'real_name_view_upload_again';

  static const faceVerifiedViewTitle = 'face_verified_view_title';
  static const faceVerifiedViewButton = 'face_verified_view_button';
  static const faceVerifiedViewNotice = 'face_verified_view_notice';

  static const verifiedResultViewTitle = 'verified_result_view_title';
  static const verifiedResultViewSuccessful = 'verified_result_view_successful';
  static const verifiedResultViewFailed = 'verified_result_view_failed';
  static const verifiedResultViewBack = 'verified_result_view_back';
  static const verifiedResultViewAgain = 'verified_result_view_again';

  static const customerViewTitle = 'customer_view_title';
  static const customerNoCert = 'customer_no_cert';

  static const buyOrderViewTitle = 'buy_order_view_title';
  static const buyOrderViewSmall = 'buy_order_view_small';
  static const buyOrderViewMax = 'buy_order_view_max';
  static const online = 'online';
  static const offline = 'offline';
  static const isOnline = 'is_online';
  static const buyOrderViewAmount = 'buy_order_view_amount';
  static const buyOrderViewAmountCustomize = 'buy_order_view_amount_customize';
  static const buyOrderViewBanks = 'buy_order_view_banks';
  static const buyOrderViewAll = 'buy_order_view_all';
  static const buyOrderViewFilter = 'buy_order_view_filter';
  static const buyOrderViewRanger = 'buy_order_view_ranger';
  static const buyOrderViewMinHintText = 'buy_order_view_min_hint_text';
  static const buyOrderViewMaxHintText = 'buy_order_view_max_hint_text';
  static const buyOrderViewSellAmount = 'buy_order_view_sell_amount';
  static const orderSplit = 'order_split';
  static const orderNoSplit = 'order_no_split';
  static const buyOrderViewLimit = 'buy_order_view_limit';
  static const buyOrderViewWantToBuy = 'buy_order_view_want_to_buy';
  static const buyOrderViewBuy = 'buy_order_view_buy';
  static const buyOrderViewBuyAmount = 'buy_order_view_buy_amount';
  static const buyOrderViewBuyAll = 'buy_order_view_buy_all';
  static const buyOrderViewGoAndPay = 'buy_order_view_go_and_pay';
  static const buyOrderViewErrorMin = 'buy_order_view_error_min';
  static const buyOrderViewErrorMax = 'buy_order_view_error_max';

  static const buyOrderInfoViewTitle = 'buy_order_info_view_title';
  static const buyOrderInfoViewSeller = 'buy_order_info_view_seller';
  static const buyOrderInfoViewBuyRate = 'buy_order_info_view_buy_rate';
  static const buyOrderInfoViewBuyAmount = 'buy_order_info_view_buy_amount';
  static const buyOrderInfoViewStep1 = 'buy_order_info_view_step_1';
  static const buyOrderInfoViewStepHintText1 = 'buy_order_info_view_step_hint_text_1';
  static const buyOrderInfoViewStep2 = 'buy_order_info_view_step_2';
  static const buyOrderInfoViewStep3 = 'buy_order_info_view_step_3';
  static const buyOrderInfoViewStepUpload3 = 'buy_order_info_view_step_Upload_3';
  static const buyOrderInfoViewStep4 = 'buy_order_info_view_step_4';
  static const buyOrderInfoViewPayAccount = 'buy_order_info_pay_account';
  static const buyOrderInfoViewCollectAccount = 'buy_order_info_collect_account';
  static const buyOrderInfoViewAlertTitle = 'buy_order_info_view_alert_title';
  static const buyOrderInfoViewCancel = 'buy_order_info_view_cancel';
  static const buyOrderInfoViewOrderCancelSecondTitle = 'buy_order_info_view_order_cancel_second_title';
  static const buyOrderInfoViewOrderId = 'buy_order_info_view_order_id';
  static const buyOrderInfoViewCollectName = 'buy_order_info_view_collect_name';
  static const buyOrderInfoViewCollectBank = 'buy_order_info_view_collect_bank';
  static const buyOrderInfoViewCollectQrcode = 'buy_order_info_view_collect_qrcode';
  static const buyOrderInfoViewCreateTime = 'buy_order_info_view_create_time';
  static const buyOrderInfoViewCancelTime = 'buy_order_info_view_cancel_time';
  static const buyOrderInfoViewChangeBankTitle = 'buy_order_info_view_change_bank_title';
  static const buyOrderInfoViewChangeBankSecondTitle = 'buy_order_info_view_change_bank_second_title';
  static const buyOrderInfoViewChangeBankContent = 'buy_order_info_view_change_bank_content';
  static const buyOrderInfoViewChangeBankButtonText = 'buy_order_info_view_change_bank_button_text';
  static const buyOrderInfoViewDownloadQrcode = 'buy_order_info_view_download_qrcode';
  static const buyOrderInfoViewCollectBankCard = 'buy_order_info_view_collect_bank_card';
  static const buyOrderInfoViewCollectBankCardAddress = 'buy_order_info_view_collect_bank_card_card_address';
  static const buyOrderInfoViewOrderCancel = 'buy_order_info_view_order_cancel';
  static const buyOrderInfoViewOrderInfo = 'buy_order_info_view_order_info';
  static const buyOrderInfoViewCollectWallet = 'buy_order_info_view_collect_wallet';
  static const buyOrderInfoViewOrderCancelContent = 'buy_order_info_view_order_cancel_content';
  static const buyOrderInfoViewCancelReason1 = 'buy_order_info_view_cancel_reason_1';
  static const buyOrderInfoViewCancelReason2 = 'buy_order_info_view_cancel_reason_2';
  static const buyOrderInfoViewCancelReason3 = 'buy_order_info_view_cancel_reason_3';
  static const buyOrderInfoViewCancelReason4 = 'buy_order_info_view_cancel_reason_4';

  static const sellOrderInfoViewTitle = 'sell_order_info_view_title';
  static const sellOrderInfoViewCancelAll = 'sell_order_info_view_cancel_all';
  static const sellOrderInfoViewSellAmount = 'sell_order_info_view_sell_amount';
  static const sellOrderInfoViewAlreadySell = 'sell_order_info_view_already_sell';
  static const sellOrderInfoViewBuyer = 'sell_order_info_view_buyer';
  static const sellOrderInfoViewBuyerRate = 'sell_order_info_view_buyer_rate';
  static const sellOrderInfoViewChangePayTitle = 'sell_order_info_change_pay_title';
  static const sellOrderInfoViewInfoTitle = 'sell_order_info_view_info_title';
  static const sellOrderInfoViewInfoID = 'sell_order_info_view_info_ID';
  static const sellOrderInfoViewInfoCreateTime = 'sell_order_info_view_info_create_time';
  static const sellOrderInfoViewInfoConfirmTime = 'sell_order_info_view_info_confirm_time';
  static const sellOrderInfoViewInfoPayTime = 'sell_order_info_view_info_pay_time';
  static const sellOrderInfoViewInfoCancelTime = 'sell_order_info_view_info_cancel_time';
  static const sellOrderInfoViewInfoPassTime = 'sell_order_info_view_info_pass_time';
  static const sellOrderInfoViewPayerPicture = 'sell_order_info_view_info_payer_picture';
  static const sellOrderInfoViewConfirmButtonText = 'sell_order_info_view_confirm_button_text';
  static const sellOrderInfoViewPassButtonText = 'sell_order_info_view_pass_button_text';
  static const sellOrderInfoViewPassDelayButtonText = 'sell_order_info_view_pass_delay_button_text';
  static const sellOrderInfoViewCancelAlertTitle = 'sell_order_info_view_cancel_alert_title';
  static const sellOrderInfoViewCancelAlertContent = 'sell_order_info_view_cancel_alert_content';
  static const sellOrderInfoViewPassAlertTitle = 'sell_order_info_view_pass_alert_title';
  static const sellOrderInfoViewPassAlertContent1 = 'sell_order_info_view_pass_alert_content1';
  static const sellOrderInfoViewPassAlertContent2 = 'sell_order_info_view_pass_alert_content2';
  static const sellOrderInfoViewPassDelayAlertTitle = 'sell_order_info_view_pass_delay_alert_title';
  static const sellOrderInfoViewPassDelayAlertContent1 = 'sell_order_info_view_pass_delay_alert_content1';
  static const sellOrderInfoViewPassDelayAlertContent2 = 'sell_order_info_view_pass_delay_alert_content2';
  static const sellOrderInfoViewPassAlertHintText = 'sell_order_info_view_pass_alert_hint_text';
  static const sellOrderInfoViewPassAlertConfirmText = 'sell_order_info_view_pass_alert_confirm_text';
  static const sellOrderInfoViewPassAlertCancelText = 'sell_order_info_view_pass_alert_cancel_text';
  static const sellOrderInfoViewCustomerTitle = 'sell_order_info_view_customer_title';
  static const sellOrderInfoViewCustomerContent = 'sell_order_info_view_customer_content';
  static const sellOrderInfoViewCustomerButton= 'sell_order_info_view_customer_button';
  static const sellOrderInfoViewCustomerViewTitle= 'sell_order_info_view_customer_view_title';
  static const sellOrderInfoViewHaveRead = 'sell_order_info_view_have_read';

  static const sellOrderViewTitle = 'sell_order_view_title';
  static const sellOrderViewSellAmount = 'sell_order_view_sell_amount';
  static const sellOrderViewSellAmountHintText = 'sell_order_view_sell_amount_hint_text';
  static const sellOrderViewCanSellAmount = 'sell_order_view_can_sell_amount';
  static const sellOrderViewAll = 'sell_order_view_all';
  static const sellOrderViewSplitTitle = 'sell_order_view_split_title';
  static const sellOrderViewCanSplit = 'sell_order_view_can_split';
  static const sellOrderViewCanNotSplit = 'sell_order_view_can_not_split';
  static const sellOrderViewSplitRange = 'sell_order_view_split_range';
  static const sellOrderViewCollectTitle = 'sell_order_view_collect_title';
  static const sellOrderViewButtonText = 'sell_order_view_button_text';

  static const buyOrderHistoryTitle = 'buy_order_history_title';
  static const buyOrderHistoryAll = 'buy_order_history_all';
  static const buyOrderHistoryIng = 'buy_order_history_ing';
  static const buyOrderHistoryDone = 'buy_order_history_done';
  static const buyOrderHistoryCancel = 'buy_order_history_cancel';
  static const buyOrderHistoryTotalAll = 'buy_order_history_total_all';
  static const buyOrderHistoryTotalIng = 'buy_order_history_total_ing';
  static const buyOrderHistoryTotalDone = 'buy_order_history_total_done';
  static const buyOrderHistoryTotalCancel = 'buy_order_history_total_cancel';
  static const buyOrderHistoryAmount = 'buy_order_history_amount';
  static const buyOrderHistorySingle = 'buy_order_history_single';
  static const buyOrderHistoryNumber = 'buy_order_history_number';
  static const buyOrderHistoryPayType = 'buy_order_history_pay_type';
  static const buyOrderHistoryTime = 'buy_order_history_time';

  static const sellOrderHistoryTitle = 'sell_order_history_title';
  static const sellOrderHistoryAll = 'sell_order_history_all';
  static const sellOrderHistoryIng = 'sell_order_history_ing';
  static const sellOrderHistoryDone = 'sell_order_history_done';
  static const sellOrderHistoryCancel = 'sell_order_history_cancel';
  static const sellOrderHistoryTotalAll = 'sell_order_history_total_all';
  static const sellOrderHistoryTotalIng = 'sell_order_history_total_ing';
  static const sellOrderHistoryTotalDone = 'sell_order_history_total_done';
  static const sellOrderHistoryTotalCancel = 'sell_order_history_total_cancel';
  static const sellOrderHistoryAmount = 'sell_order_history_amount';
  static const sellOrderHistorySingle = 'sell_order_history_single';
  static const sellOrderHistoryNumber = 'sell_order_history_number';
  static const sellOrderHistoryPayType = 'sell_order_history_pay_type';
  static const sellOrderHistoryTime = 'sell_order_history_time';
  static const sellOrderHistoryInfo = 'sell_order_history_info';
  static const sellOrderInfoViewCollectAccount = 'sell_order_info_view_collect_account';
  static const sellOrderInfoViewConfirmAlertContent = 'sell_order_info_view_confirm_alert_content';
  static const sellOrderInfoViewEmptyTitle = 'sell_order_info_view_empty_title';
  static const sellOrderInfoViewEmptySplit = 'sell_order_info_view_empty_split';
  static const sellOrderInfoViewEmptyRange = 'sell_order_info_view_empty_range';
  static const sellOrderInfoViewPassHintText = 'sell_order_info_view_pass_hint_text';

  static const buyCoinsQuicklyViewTitle = 'buy_coins_quickly_view_title';
  static const buyCoinsQuicklyViewPayType = 'buy_coins_quickly_view_pay_type';
  static const buyCoinsQuicklyViewAmount = 'buy_coins_quickly_view_amount';
  static const buyCoinsQuicklyViewPayAccount = 'buy_coins_quickly_view_pay_account';
  static const buyCoinsQuicklyViewButtonText = 'buy_coins_quickly_view_button_text';
  static const buyCoinsQuicklyViewAmountHintText = 'buy_coins_quickly_view_amount_hint_text';

  static const transferViewTitle = 'transfer_view_title';
  static const transferViewHistory = 'transfer_view_history';
  static const transferViewContentTitle = 'transfer_view_content_title';
  static const transferViewContent = 'transfer_view_content';
  static const transferViewAddress = 'transfer_view_address';
  static const transferViewWay1 = 'transfer_view_way_1';
  static const transferViewWay2 = 'transfer_view_way_2';
  static const transferViewScan = 'transfer_view_scan';
  static const transferViewHistoryLater = 'transfer_view_history_later';
  static const transferViewSuss = 'transfer_view_suss';
  static const transferViewSussHint = 'transfer_view_suss_hint';
  static const transferViewAmount = 'transfer_view_amount';
  static const transferViewAmountHintText = 'transfer_view_amount_hint_text';
  static const transferViewNote = 'transfer_view_info';
  static const transferViewNoteHintText = 'transfer_view_info_hint_text';
  static const transferViewAlertContent = 'transfer_view_alert_content';

  static const transferHistoryViewTitle = 'transfer_history_view_title';
  static const transferHistoryViewToday = 'transfer_history_view_today';
  static const transferHistoryViewMonth = 'transfer_history_view_month';

  static const qrcodeViewTitle = 'qrcode_view_title';
  static const qrcodeViewSave = 'qrcode_view_save';

  static const payViewTitle = 'pay_view_title';
  static const payViewAmount = 'pay_view_amount';
  static const payViewCountdownTime = 'pay_view_countdown_time';
  static const payViewBalance = 'pay_view_balance';
  static const payViewOrderId = 'pay_view_order_id';
  static const payViewCreateTime = 'pay_view_create_time';
  static const payViewEndTime = 'pay_view_end_time';
  static const payViewSuccess = 'pay_view_success';
  static const payViewSuccessContent = 'pay_view_success_content';
  static const payViewFailed = 'pay_view_failed';
  static const payViewButtonText = 'pay_view_button_text';

  static const activitySignInViewTitle = 'activity_sign_in_view_title';
  static const activitySignInViewAlreadyDays = 'activity_sign_in_view_already_days';
  static const activitySignInViewRecharge = 'activity_sign_in_view_recharge';
  static const activitySignInViewIn = 'activity_sign_in_view_in';
  static const activitySignInViewDays = 'activity_sign_in_view_days';
  static const activitySignInViewNotReached = 'activity_sign_in_view_not_reached';
  static const activitySignInViewReached = 'activity_sign_in_view_reached';
  static const activitySignInViewAlreadyReached = 'activity_sign_in_view_already_reached';
  static const activitySignInViewSignIn = 'activity_sign_in_view_sign_in';

  static const flashOrderHistoryViewTitle = 'flash_order_history_view_title';
  static const flashOrderHistoryViewFilter = 'flash_order_history_view_filter';
  static const flashOrderHistoryViewTimeRange = 'flash_order_history_view_time_range';
  static const flashOrderHistoryViewTimeDay1 = 'flash_order_history_view_time_day_1';
  static const flashOrderHistoryViewTimeDay7 = 'flash_order_history_view_time_day_7';
  static const flashOrderHistoryViewTimeDay30 = 'flash_order_history_view_time_day_30';
  static const flashOrderHistoryViewOrderType = 'flash_order_history_view_order_type';
  static const flashOrderHistoryViewOrderTypePay = 'flash_order_history_view_order_type_pay';
  static const flashOrderHistoryViewOrderTypeConfirm = 'flash_order_history_view_order_type_confirm';
  static const flashOrderHistoryViewOrderTypeDone = 'flash_order_history_view_order_type_done';
  static const flashOrderHistoryViewOrderTypeCancel = 'flash_order_history_view_order_type_cancel';
  static const flashOrderHistoryViewButtonConfirm = 'flash_order_history_view_button_confirm';
  static const flashOrderHistoryViewButtonCancel = 'flash_order_history_view_button_cancel';

  static const flashOrderInfoViewTitle = 'flash_order_info_view_title';
  static const flashOrderInfoViewAlert = 'flash_order_info_view_alert';
  static const flashOrderInfoViewAddress = 'flash_order_info_view_address';
  static const flashOrderInfoViewRechargeAddress = 'flash_order_info_view_recharge_address';
  static const flashOrderInfoViewAddressHint = 'flash_order_info_view_address_hint';
  static const flashOrderInfoViewCanExchange = 'flash_order_info_view_can_exchange';
  static const flashOrderInfoViewId = 'flash_order_info_view_id';
  static const flashOrderInfoViewCreateTime = 'flash_order_info_view_create_time';
  static const flashOrderInfoViewPayTime = 'flash_order_info_view_pay_time';
  static const flashOrderInfoViewConfirmTime = 'flash_order_info_view_confirm_time';
  static const flashOrderInfoViewCancelTime = 'flash_order_info_view_cancel_time';
  static const flashOrderInfoViewLink = 'flash_order_info_view_link';
  static const flashOrderInfoViewButton = 'flash_order_info_view_button';
  static const flashOrderInfoViewTimeOut = 'flash_order_info_view_time_out';
  static const flashOrderInfoViewAlreadyPay = 'flash_order_info_view_already_pay';
  static const flashOrderInfoViewAlreadyConfirm = 'flash_order_info_view_already_confirm';
  static const flashOrderInfoViewLateTime = 'flash_order_info_view_late_time';
  static const flashOrderInfoViewDoneTime = 'flash_order_info_view_done_time';
}
