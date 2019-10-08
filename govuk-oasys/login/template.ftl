<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true>
    <!DOCTYPE html>

    <#-- Attempt to reverse-engineer code for page’s current language, as Keycloak does not currently make this available -->
    <#assign LANG_CODE = "en">
    <#if .locale??>
        <#assign LANG_CODE = .locale>
    </#if>
    <#if locale??>
        <#list locale.supported>
            <#items as supportedLocale>
                <#if supportedLocale.label == locale.current>
                    <#if supportedLocale.url?contains("?kc_locale=")>
                        <#assign LANG_CODE = supportedLocale.url?keep_after("?kc_locale=")[0..1]>
                    </#if>
                    <#if supportedLocale.url?contains("&kc_locale=")>
                        <#assign LANG_CODE = supportedLocale.url?keep_after("&kc_locale=")[0..1]>
                    </#if>
                </#if>
            </#items>
        </#list>
    </#if>
    <html lang="${LANG_CODE}" class="govuk-template app-html-class">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
        <meta name="robots" content="noindex, nofollow">
        <meta name="theme-color" content="blue" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta property="og:image" content="${url.resourcesPath}/assets/images/govuk-opengraph-image.png?0.22.1">
        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title><#nested "title"> - ${realm.displayName!'GOV.UK'}</title>

        <#-- Start GOV.UK Template <head> content -->


        <link rel="shortcut icon" href="${url.resourcesPath}/assets/images/favicon.ico?0.22.1" type="image/x-icon" />
        <link rel="mask-icon" href="${url.resourcesPath}/assets/images/govuk-mask-icon.svg" color="#0b0c0c">
        <link rel="apple-touch-icon" sizes="180x180" href="${url.resourcesPath}/assets/images/govuk-apple-touch-icon-180x180.png">
        <link rel="apple-touch-icon" sizes="167x167" href="${url.resourcesPath}/assets/images/govuk-apple-touch-icon-167x167.png">
        <link rel="apple-touch-icon" sizes="152x152" href="${url.resourcesPath}/assets/images/govuk-apple-touch-icon-152x152.png">
        <link rel="apple-touch-icon" href="${url.resourcesPath}/assets/images/govuk-apple-touch-icon.png">

        <#-- End GOV.UK Template <head> content -->


        <#-- GOV.UK/MoJ Frontend stylesheets -->
        <link href="${url.resourcesPath}/css/moj-frontend.css?0.22.1" media="screen" rel="stylesheet" />
        <link href="${url.resourcesPath}/css/app.css?0.22.1" media="screen" rel="stylesheet" />
        <#-- End GOV.UK/MoJ Frontend stylesheets -->

        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
            </#list>
        </#if>
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>
    </head>

    <body class="${properties.kcBodyClass!}">
    <#-- Add GOV.UK Template <body> JavaScript class -->
    <script>
        document.body.className = ((document.body.className) ? document.body.className + ' js-enabled' : 'js-enabled');
    </script>


    <#-- Start GOV.UK Template header -->

    <a href="#main-content" class="govuk-skip-link">Skip to main content</a>

    <div id="global-cookie-message" class="app-cookie-banner js-cookie-banner">
        <p class="govuk-width-container">GOV.UK uses cookies to make the site simpler. <a href="https://www.gov.uk/help/cookies" class="govuk-link">Find out more about cookies</a></p>
    </div>
    <header class="${properties.kcHeaderClass!}" role="banner">
        <div class="moj-header__container app-header__logotype-text">
            <div class="moj-header__logo">
                <svg role="presentation" focusable="false" class="moj-header__logotype-crest" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 40" height="40" width="40">
                    <path fill="#ffffff" fill-rule="evenodd" d="M38.1 16.9c.1 1.8 2.2 1.3 1.9 2.7 0-.9-3-.8-3-2.6 0-.3.1-.7.3-.9-.1-.1-.2-.1-.5-.1-.6 0-1.2.6-1.2 1.3 0 2.2 3 2.6 3 5.1 0 .6-.2 1-.6 1.2.2 0 .7-.1.8-.3-.2 1-1.2 1-1.6.6h-.3c.2.4.4.8.9.7-.9.7-2-.2-1.8-1.2-.2-.3-.4-.7-.6-.9-.1-.2-.2-.1-.2.1 0 .8-.6 1.6-.6 2.1 0 .6.6 1.1.8 1.1s.3-.2.4-.2c.1.1.1.2.1.7 0 .2 0 1 .1 1.7 0-.2.2-.3.3-.4.2-.1.4-.2.7-.1.1 0 .3.1.3.2.1.1.1.2.1.3 0 .2-.2.4-.3.6-.2.1-.3.2-.6.1-.2 0-.3-.1-.4-.2v-.1.7c0 .6-.1.8-.3.9 0-.1-.2-.2-.3-.2-.1 0-.3.1-.3.2 0 .2.3.2.3.6s-.8.8-1.3.8c.1-.2.2-.8.3-1.1-.1.1-.3.3-.4.7-.1.4-.3.4-.6.3.2-.2.6-1.1 1-1.3.4-.3.6-.4.7-1.1.1-.7 0-1.1 0-1.7 0-.8-.3-.7-.6-.7-.6 0-2.6-1.3-2.6-2.7v-.4c-.9 0-1.5.2-1.5 1.1 0 .3 0 .6.2.8.2.1.3.3 0 .4-.3.1-3.1 1.3-3.1 1.3-.3.1-.4 0-.6-.2-.1-.2-.3-.2-.4-.1-.2.1.1.2.1.4s-.1.7-1.3.6l.3-.6c.1-.2.1-.3.1-.3-.1 0-.1.1-.2.3l-.3.4h-.4l1-1c.2-.2.6-.4 1.1-.4.7-.1 2.9-.4 2.9-1.1 0-.8-.9-.8-.9-1.9 0-1 .4-2 3-1.9-.2-.7-.9-1.1-1.6-1.2-1.3-.3-1.7-1.2-1.8-2.1h-1c-.8 0-1.2-.3-1.5-.1-.1.1-.1.2 0 .3.1.2.3.7.6 1 .1 0 .4 0 .4.2s-.1.2-.1.3 0 .2.1.2.1-.1.1-.2c.1-.1.3-.1.7 0 .2.2.6.6.7 1-.3-.1-.8-.3-.9-.3s-.1.1 0 .1.4.2.6.3v.3c-.1-.1-.7-.4-1.1-.6-.3-.1-.6-.2-.8-.7-.2-.4-.8-1.6-1-1.9-.1-.2-.1-.3 0-.4.1-.1.1-.2.2-.3.1-.2.2-.2.4-.2s.8 0 1-.1c0 0 .1 0 .2-.1-.6-.6-1.2-1.4-1.2-1.6-.1-.1-.2-.2-.3-.2s-.2 0-.3.1l-.1.1c0-.1-.1-.1-.1-.2l-.3-.3c.2-.1.3-.3.4-.3.1-.1.2-.2.3-.2h.3c.2 0 .2 0 .3.1.2.2.6.4.8.7 0 0 .1 0 .1.1l.1-.1c.1-.1.2-.1.3-.1s.2.1.3.2.2.3.2.6v.2l.6.6c.1-.7.4-1.4.9-2h-.1v-.1c.1-.3.2-.9.3-1.1v-.3l.8.3.1-.1c.7-.7 2.3-1.1 2.3-2.1 0-.2-.1-.6-.3-.8.1.1.1.3.1.6 0 .2-.4.8-1.1.8-.3 0-.7-.3-.8-.3s-.2.1-.3.1c0 .4-.2.8-.3.8.1-.2 0-.6 0-.6-.1 0-.1.1-.1.4 0 .3-.2.7-.7.7.1-.1.2-.6.1-.7-.1-.1-.2.1-.3.1s-.2-.1-.2-.2-.2 0-.2-.1.2-.3.4-.3c.2-.1.6-.2.6-.4-.1-.2-.9.1-1.1.3-.4.3-.2-.1-.3-.2-.2-.4 0-.4.2-.7.2-.2.8-.7 1.5-1 0-.2.1-.3.3-.4.2-.1.6-.2.8-.3l-3.8-4c-.1-.1-.1-.1 0-.2 0 0 .1 0 .2.1l4 3.9c.3-.6.4-.9.3-1.3.4.2.9.7 1 1.2 1.2 0 1.6.8 1.9.4 0 .2-.1.3-.6.4 1.5.3 1 1.3 1.8 1.4-.1.1-.3.2-.6.1.9 1.3 0 2.1.7 2.8-.2.1-.7-.1-.9-.6.2 1.1-.1 1.7.1 2.1-.3.1-.6-.2-.7-.6-.1.2-.1.4-.2.7l.3.1-.1.1c-.6.6-.8.9-.9 1l-.1.1-.1-.1c-.3.4-.7.8-.7 1.2 0 .4.6 1.3 1.2 2.1v-.2c0-.1.1-.3.2-.4.1-.1.2-.1.4-.1s.4.1.6.3c.1.2.2.3.2.6 0 .1-.1.3-.2.4-.1.1-.2.1-.4.1-.1 0-.3-.1-.4-.1.4.6.9 1.2 1.1 1.7.4.9.9 1.4 1.3 1.4.6 0 1.1-.4 1.1-1.1 0-2.3-3-2.6-3-5.2 0-1.2 1-1.8 1.7-1.8.4 0 .7.1.9.3h.2c1.5 0 .6 1.9 1.7 2-.3.5-1 .2-1.3-.7zM30.3 10c.3-.2.8-.3 1.2-.3-.3-.1-.6-.3-.8-.3-.4-.1-.3.4-.4.6zm-2.7 5.5c0-.1 0-.3-.1-.3 0 0-.1-.1-.2-.1s-.1 0-.2.1-.1.2-.1.3c0 .2.1.4.3.4.1 0 .1 0 .2-.1 0 0 .1-.1.1-.3zm8.7 12.6v.2c.1.2.4.2.7 0 .1-.1.2-.2.2-.3v-.2c-.1-.1-.1-.1-.2-.1s-.3 0-.4.1c-.2.1-.3.2-.3.3zm-1.9-8.3c0 .1.1.3.2.4.1.1.2.2.4.2.1 0 .1 0 .2-.1s.1-.1.1-.2-.1-.3-.2-.4c-.1-.1-.2-.2-.4-.2-.1 0-.1 0-.2.1s-.1.1-.1.2zm-.8-3.2c.3-.3.9-1 .9-1l-.3-.3v.6c-.1-.1-.2-.2-.2-.3l-.2.3c.1 0 .3 0 .3.1-.2.2-.6.1-.7 0-.2-.2-.3-.3-.3-.4.1-.1.3-.1.4.1.2 0 .2-.2.2-.3-.1-.1-.2-.1-.3-.1.3-.2.6-.4.4-.9-.4.1-.6.3-.7.7 0-.1-.1-.3-.2-.3s-.3.1-.3.3c.2-.1.4.1.3.3-.1.1-.3.1-.6 0-.3-.4-.3-.6-.1-.9.1.1.1.2.1.4l.3-.6c-.1 0-.2.1-.3 0 .1-.1.2-.2.4-.3l-.7-.2c.1.2 0 .4 0 .6-.1-.1-.2-.2-.2-.3l-.3.6c.1-.1.3-.1.4-.1-.1.2-.4.3-.7.2-.2-.1-.3-.3-.3-.4.1-.1.3-.1.4.1.2-.1.2-.3.1-.4-.1-.1-.2-.1-.4 0 .3-.3.4-.6.3-1-.3.1-.6.4-.6.8 0-.1-.1-.2-.2-.2s-.3.1-.2.3c.2-.1.4.1.3.3-.1.1-.2.1-.6 0-.2-.1-.4-.2-.3-.6.1 0 .2.2.3.2l.1-.4h-.3c.1-.1.3-.2.4-.3l-.4-.2s-.2.9-.4 1.3l4.2 2.3zm0 7.9c.1-.2.1-.6 0-.7-.2-.1-.4 0-.7.2-.1.2-.1.6 0 .7.1.1.5 0 .7-.2zm1.1-1.9c.1-.2.1-.6 0-.7-.2-.1-.4 0-.7.2-.1.2-.1.6 0 .7.3.1.6 0 .7-.2zM27.4 18c.2-.1.4 0 .7 0 .2.1.3.3.4.4v.4l-.3.3c-.2.1-.4 0-.7 0-.5-.1-.6-.4-.5-.8.1-.2.2-.3.4-.3zm.2 1c.1.1.3.1.4 0 .1 0 .1-.1.2-.1v-.2c0-.1-.1-.2-.3-.3-.1-.1-.3-.1-.4 0-.1 0-.1.1-.2.1-.1.1.1.3.3.5zm4.8 7.2c.1-.1.2-.2.4-.2s.3.1.4.2c.1.1.2.3.2.6 0 .2-.1.4-.2.6-.1.1-.2.2-.4.2-.1 0-.3-.1-.4-.2-.1-.1-.2-.3-.2-.6 0-.2 0-.5.2-.6zm.3 1.1c.1 0 .2 0 .2-.1.1-.1.1-.2.2-.4 0-.3-.1-.6-.3-.6-.1 0-.2 0-.2.1-.1.1-.1.2-.2.4 0 .2 0 .3.1.4.1.1.1.2.2.2zm-4.8-13.8c.2-.1.3-.2.6-.2.1 0 .2.1.3.2s.1.2.1.4-.1.3-.3.6c-.3.2-.8.2-.9 0-.1-.3 0-.6.2-1zm0 .7v.2c.1.1.3.1.6 0 .1-.1.2-.2.2-.3v-.2c0-.1-.1-.1-.2-.1s-.2 0-.3.1c-.2 0-.3.2-.3.3zm5.7 13.7c.2-.1.4-.2.7-.1.4.1.8.4.7.8 0 .2-.1.3-.3.4-.1.1-.3.1-.6.1s-.3-.1-.6-.2c-.1-.1-.2-.3-.1-.6-.1-.2 0-.3.2-.4zm.4.9c.3 0 .6-.1.6-.3 0-.2-.2-.3-.4-.4-.2 0-.3 0-.4.1 0 0-.1.1-.1.2-.2.1 0 .3.3.4zm3.3-1.9c0-.6.4-1 1-1s1 .4 1 1-.4 1-1 1c-.5 0-1-.4-1-1zm.3 0c0 .4.3.8.8.8s.8-.3.8-.8c0-.4-.3-.8-.8-.8-.4.1-.8.5-.8.8zm-23.3-5.8c-.1.3.1.3.1.7 0 .3-.2.4-.6.6.2-.4 0-.7-.3-.8.1.8-.6.9-.8.8.2 0 .3-.4.2-.8-.1.2-.4.4-.7.4s-.4-.2-.6-.4c.3.2.6 0 .6-.2 0-.1-.3-.2-.3-.4 0-.6.6-.3.6-.8 0-.2-.1-.3-.2-.3s-.3.1-.3.3c-.3-.2 0-.9-.1-1.2 0 .7-.4.6-.6.9-.2-.2 0-.7-.2-1.2-.1.6-.3.4-.3.9-.6-.3-1.7-.2-2 .2 1 .8 2.2 1.2 2.2 2.4 0 .9-1.5 1.3-1.5 1.9 0 .6 1.5 2 2.2 2 .2 0 .3-.3.6-.3h.6c.2 0 .3.2.3.3.3 0 .8.6.3 1-.1-.2-.3-.6-.8-.3.2.4 0 .8-.4 1 .1-.2.2-.6-.1-.6s0 .2-.7.2c-.6 0-.6 0-.8-.3-.2-.3-.4-.4-.6-.4s-.2.3 0 .6c-1.2 0-.7-1.2-1.3-1.6v.9c-.4-.5-.8-.9-.8-1.3-.1-.3 0-.6-.3-.8-.1 0-.2-.1-.2-.3 0-.1.1-.1.3-.2.2-.1.6-.3.6-1 0-.4-.1-1.1-.9-1.7.1 1 0 1.9-.4 2.7-.6 1-1.7 1.7-2.2 1.9-.6.2-1.3.4-1.3 1.2 0 1.4.7 2.2 1.2 2.2.4 0 .3-.4.9-.4.2 0 .6.1.6.3.3-.1.7.1.7.4 0 .3-.1.4-.3.6.2-.4-.3-.4-.4-.4-.1.1 0 .2 0 .4s-.1.4-.4.6c.1-.1.1-.3-.2-.3-.2 0-.3.4-.7.4-.6 0-.7-.2-1.2-.1-.3.1-.3.3-.2.3-.7 0-.6-.8-.4-.9.1-.1.2-.2 0-.4-.2-.1-.6 0-.7.3-.6-1.1.2-1 0-2.2-.1.6-.4.9-.7 1 .1-.2-.1-.8-.1-1.2 0-.9.6-1.2.6-1.4 0-.2-.2-.4 0-.6.1-.1.3.1.6.1.7 0 1.2-.9 1.3-2 .1-1.2.7-2.1 1.1-3 0-.1 0-.3.1-.4-.6.7-1 1.6-1.7 2.1.1.8-1.5 1.7-2.3 1 .3 0 .8-.1 1-.6-.1 0-.2 0-.3-.1-.6.3-1.3-.1-1.3-.7.2.2.4.3.8.2.2-.1.1-.4.1-.8 0-2.3 3.6-3.9 3.6-5.8 0-.6-.3-.9-.8-.9-.2 0-.4.1-.7.2.2.1.3.3.3.6 0 2.1-3.5 1.9-3.7 3.3-.1-1.8 2-1.4 2.1-2.9-.4.7-1.2 1.1-1.7.9 1.1 0 .8-2.2 2-2.2.1 0 .2 0 .4.1.3-.3.8-.4 1.1-.4.6 0 1.3.3 1.3 1.3 0 2.2-3.6 3.7-3.6 5.8 0 .7.4 1 1 1 1.2 0 2.1-2.2 3.5-4.1.9-1.2 1.5-3.7 2-4.9-.7.4-.8 1.8-1.6 1.9.4-.3.1-1.4.4-2.3.1-.3.1-.6.1-.9-.4.6-.3 2.2-1.1 2.4.3-.3 0-.9 0-1.4 0-1 .6-1.1.6-2.1-.4.2-.3 1.4-1.2 1.4.7-.7 0-1.3.8-2.1-.4-.2-.8-.6-.8-.9.3-.2.7-.3 1-.3-.3-.2-.2-.4 0-.7.1.2.2.3.3.3.3-.1.8-.6 1.5-.8.5-.2 1.3-.5 1.6-.5.1 0 .1-.2.1-.3.2 0 .6 0 .7.3.2-.2.6-.3.9-.3.2.4.2.8 0 1.2.4 0 .7.4 1.1.3-.3.4-.8.3-1.2.2 1.2.3 1.5 1.6 2.1 1.7-1.2.7-1.7-.3-2.3-.3 1.7.9 1.7 1.9 2.1 1.9-.6.4-.9-.1-1.6-.3 1.3.9 1.3 1.6 1.2 2.1.3.2.2.6.2 1 .2-.1.6-.2.8-.2-.1.1-.2.2-.2.3-.7.8-1.1 1.4-1.5 2.4-.3-.2-.6-.6-.8-.7-.2-.2-.6-.2-.7-.2.4.4 1.8 2 2.2 2.4.4.4.3.8.4 1.2.4.4.8.7.7.9zM7.5 10.2c.4 0 .6-.6.4-.9-.4.2-1 .3-1.3.4.5.2.5.5.9.5zm2.3 2.5c.4-.2.4-.7.3-.9-.1-.2-.2-.4-.3-.4-.2 0-.4-.1-.4-.3-.1-.2.2-.3.4-.6-.2-.1-.4-.2-.2-.3.2-.1.4.1.4 0 .1-.1-.1-.2-.2-.3s-.2-.1-.3 0l-1.2.4c-.1 0-.3 0-.3.1s-.1.3 0 .3.1-.3.3-.3.2.1 0 .4c.4 0 .6-.1.7.2.1.2 0 .3-.1.6-.1.1 0 .3 0 .6.1.2.5.7.9.5zm.1-3.5c.2-.2 0-.4.3-.9-.3.2-.8.5-1.3.7.3.3.7.5 1 .2zm-.7-3.1c.1.1.1.2.1.3-.1 0-.1-.1-.3-.2v.6c.1-.1.2-.1.2-.2 0 .3-.1.6-.3.6l-.3-.3c0-.1.1-.2.2-.1 0-.3-.2-.3-.3-.2.1-.4.1-.6-.2-.7-.3.3-.1.4.1.6-.2-.1-.5.1-.2.4 0-.2.2-.1.2 0s-.1.3-.4.4c-.3.1-.4-.1-.5-.3.1 0 .2 0 .4.1l.1-.5c-.1.3-.2.3-.3.4 0-.1.1-.4.1-.4l-.7.2s.3.1.4.2c0 0-.1.1-.4 0l.2.4c0-.2.1-.3.2-.3.1.2.1.4-.2.6-.2.2-.4.1-.4 0-.1-.1 0-.3.2-.2 0-.3-.3-.3-.3-.1 0-.3-.1-.6-.4-.6-.1.3 0 .6.3.7-.2 0-.3.1-.1.3 0-.2.1-.2.2-.1s0 .2-.1.3c-.1.1-.3.1-.6-.2h.2L6 7.3v.3c-.1-.1-.1-.1-.1-.3l-.2.2c.2.2.6.5.9.9.3-.2 1-.6 1.5-.7.4-.2 1.1-.4 1.6-.4-.1-.6 0-1 0-1.2h-.5zm-2.7-.7l.2.4.1-.3v.6c0 .1.1.3.3.3.1 0 .3-.1.3-.3 0-.1-.1-.2-.1-.2 0-.1-.2-.3-.3-.4h.4v-.4l-.4.2v-.4l-.4.1.2.3-.3.1zm1.4.4c.1-.2.1-.3 0-.4-.1-.1-.2-.1-.3 0-.1.1-.1.2 0 .3.1.1.2.1.3.1zm.6-.5c.1-.1.1-.2 0-.3s-.2-.1-.3 0-.2.2 0 .3c.1.1.2.1.3 0zm.5.1c.1-.1.1-.2 0-.3s-.2-.1-.3 0c-.1.1-.1.2 0 .3.1.1.3.1.3 0zm.2.5c.1.1.2.1.3 0s.1-.2 0-.3h-.3c-.2 0-.2.3 0 .3zm-2.7.4c.1 0 .2-.1.2-.2s-.1-.2-.2-.2-.2.1-.2.2.1.2.2.2zm-.7.1c.1 0 .2-.1.2-.2S6 6 5.8 6c-.1 0-.2.1-.2.2s.1.2.2.2zm-.1.2c0-.1-.1-.2-.2-.2s-.2.1-.2.2.1.2.2.2.2 0 .2-.2zm.1.7c0-.1-.1-.2-.2-.2s-.2.1-.2.2.1.2.2.2.2-.1.2-.2zm15.7 16.9c-.1 0-.1.1-.1.1 0 .1 1-.1 1 .1 0 .1-.2.2-.6.2h-.1c0 .1.1.1.1.1v.1s0 .1 0 0h-.1s-.1 0 0 .1h-.1v-.1h-.1v-.1h.1l.1.1.1-.1-.1-.1h-.3c.1.1.1.2.1.3v.1h-.1s0 .1-.1.1H21c0-.1.1 0 .1-.1 0 0 0-.1.1-.1s.1.1.2.1h.1-.1v-.1c-.1 0-.1.1-.2.1 0 .1-.1.2-.1.2l-.1.1c-.1 0-.1 0-.1.1v-.1h-.1l-.1.1v-.1s0 .1-.1.1c0 0-.1 0-.1-.1v.2s-.1 0-.1-.1v-.1c-.1.1-.1 0-.1 0s0-.1.1-.1h.1c-.1 0-.1 0-.1-.1h.1v.1h.4v-.1c-.1 0-.1 0-.1-.1-.4-.2-.4-.3-.4-.3-.1 0-.2 0-.1-.1 0 .1.1.1.1 0 0 0-.1 0 0-.1v-.1h.1-.1.1l.1.1h.1v.1c0 .1 0 .1.1.1s.1.2.2.2v-.2s0-.1.1-.1l.1-.1v-.1h.2s.1 0 .1.1h.1s0 .1-.1.1c0 0 0 .1-.1.2.4-.1.8 0 .9 0 .2 0 .4-.1.4-.1 0-.1-1 .1-1-.1-.4-.4-.3-.4-.2-.4 0 0 0-.1 0 0 .2-.2.6 0 .7-.1 0 0-.2.1-.3.1.3.1.4-.1.8 0-.3-.1-.7.3-1.2 0 0 .1 0 0 0 0zm-.7 0c0 .1 0 .1 0 0 .1.1.1.1 0 0 .1.1.1.1 0 0zm0 0s-.1 0 0 0c-.1 0-.1 0 0 0-.1.1 0 0 0 0zm-.1.3s0 .1 0 0c0 .1.1.1 0 0 .1 0 .1 0 0 0 .1 0 .1 0 0 0 .1-.1.1-.1.1 0h-.1c0-.2 0-.2 0 0 0-.2.1-.2 0 0zm1.1-1.6c-.1 0-.3 0-.3.1s.7.1.9.1c.3 0 .3.1.3.1 0 .1-.3.1-.6.1h.3c.1 0 0 0 0 0h.1v.2h-.1c0 .1-.1 0-.1.1v.1h-.1v-.1s0 .1-.1.1 0-.1.1-.1H22s0-.1.1-.1h.1v-.1h-.5v.1s.1.1 0 .1h-.1s0 .1-.1.1h-.3c0-.1.1 0 .1-.1h-.1s0-.1.1-.1.1.1.2.1h.1-.1c-.1 0 0-.1 0-.2h-.1c-.4-.1-.2.1-.4.1 0 0 0 .1-.1.1 0 .1-.1.2-.2.1-.1 0-.2 0-.2.1v-.1h-.1c0 .1-.1.1-.1.1v-.2s0 .1-.1.1c0 0-.1 0-.1-.1v.2s-.1 0-.1-.1v-.1c-.1.1-.1 0-.1 0s0-.1.1-.1h.1c-.1 0-.1-.1-.1-.1h.1v.1c0 .1.2 0 .2 0h.2v-.1h-.1c-.1-.1-.1 0-.1 0-.1 0-.2 0-.1-.1 0 .1.1.1.1 0-.1 0-.1 0 0-.1v-.1s0-.1.1 0h-.1.1l.1.1h.1v.1c0 .1 0 .1.1.1h.1v-.1s0-.1.1-.1l.1-.1V23h.2s.1 0 .1.1h.1s0 .1-.1.1c0 0 0 .1-.1.2.3-.1 1 0 1.2 0 .1 0 .4 0 .4-.1 0 0 0-.1-.2-.1s-1 .2-1-.1c-.2-.3.1-.3.2-.2.1-.1.1-.1 0 0 .2-.2.6 0 .7-.1 0 0-.2.1-.3.1.3.1.4-.1.8 0-.3-.1-.8.1-1.2 0 .1 0 .1 0 0 0zm-.9 0s-.1-.1 0 0c-.1 0-.1 0 0 0zm.1.1s-.1 0 0 0l-.1-.1c-.1.1 0 .1.1.1h-.1v.1l.1-.1c-.1.1-.1.1 0 0-.1.1-.1.1 0 0-.1 0-.1 0 0 0-.1 0-.1 0 0 0-.1 0-.1 0 0 0zm0 0c0-.1 0-.1 0 0 0-.1 0 0 0 0zm2.2-.9s0 .1 0 0c0 .1 0 .1 0 0 0 .1 0 .1 0 0v.1c0 .1-.1 0-.1.1 0 0 .1 0 0 .1H23v-.1s0 .1-.1.1v-.1h-.2s0-.1.1-.1h.1v-.1h-.2c-.1 0-.1.1-.2.1h-.2v.1s.1.1 0 .1h-.1s0 .1-.1.1h-.3c0-.1.1 0 .1-.1h-.1s0-.1.1-.1.1.1.2.1h.1-.2c-.1 0-.1-.1 0-.2 0 0 0 .1-.1.1-.6-.1-.3.2-.8.1 0 0 0 .1-.1.1h-.1l-.1.1c-.1 0-.1 0-.2.1v-.1h-.1c0 .1-.1.1-.1.1v-.2s0 .1-.1.1c0 0-.1 0-.1-.1v.2s-.1 0-.1-.1v-.1c-.1.1-.1 0-.1 0s0-.1.1-.1h.1c-.1 0-.1-.1-.1-.1h.1v.1c0 .1.2 0 .2 0h.2s-.1-.1 0-.1v-.1h-.1l-.2-.2v-.1c-.1 0-.2 0-.1-.1 0 .1.1.1.1 0-.1 0-.1-.1 0-.1v-.1s0-.1.1 0c0 0-.1 0-.1-.1h.1s0 .1.1.1h.1v.1c0 .1 0 .1.1.1s.1.1.2.1v-.1s0-.1.1-.1l.1-.1v-.1h.3s.1 0 .1.1h.1s0 .1-.1.1c0 0 0 .1-.1.2.4-.1 1.5 0 1.7 0 .1 0 .4 0 .4-.1 0 0 0-.1-.3-.1-.2 0-1.3.2-1.3-.1 0-.2.3-.1.7-.1.1-.1.6 0 .7 0 0 0-.2.1-.3.1.3.1.4-.1.8 0-.2-.1-.7.2-1.1.1h-.1c-.2 0-.6 0-.6.1 0 .2.9.1 1.2.1.3 0 .4.1.4.1 0 .1-.3.1-.4.1h.3c-.4-.1-.4-.1-.3 0-.1 0 0-.1 0 0zm-2.2-.5s0 .1 0 0c.1.1.1.1.1 0H21zm-.1 0s0-.2 0 0c0 0-.1 0 0 0zm-.1.2c.1.1.1 0 0 0 .1 0 .1 0 0 0 .1 0 .1-.1 0 0l.1-.1h-.1c.1 0 .1 0 0 .1.1-.1.1-.1 0 0 .1-.1 0 0 0 0zm-1.9-2c0 .1-.3.1-.4.1h.5v.2c0 .1-.1 0-.1.1 0 0 .1 0 0 .1h-.1v-.1.1-.1h-.2s0-.1.1-.1h.1V20h-.2c-.1 0-.1.1-.2.1h-.2v.1s.1.1 0 .1H18s0 .1-.1.1h-.3c0-.1.1 0 .1-.1h-.1s0-.1.1-.1.1.1.2.1h.1-.1c-.1 0-.1-.1 0-.1h-.1c-.6-.1-.3.2-.8.1 0 0 0 .1-.1.1l-.1.1h-.1c-.1 0-.2 0-.2.1v-.2h-.1c0 .1-.1.1-.1.1v-.2s0 .1-.1.1c0 0-.1 0-.1-.1v.2s-.1 0-.1-.1v-.1c-.1.1-.1 0-.1 0s0-.1.1-.1h.1c-.1 0-.1-.1-.1-.1v.1c0 .1.2 0 .2 0h.2v-.1h-.1l-.2-.2v-.1c-.1 0-.2 0-.1-.1 0 .1.1.1.1 0-.1 0-.1-.1 0-.1v-.1s0-.1.1 0c0 0-.1 0-.1-.1h.1s0 .1.1.1h.1v.1c0 .1 0 .1.1.1s.1.1.1.1v-.1s0-.1.1-.1l.1-.1v-.1h.3s.1 0 .1.1h.1s0 .1-.1.1c0 .1 0 .1-.1.2.5-.1 1.5 0 1.8 0-.4.1-.1 0 0 0-.1-.1-.1-.1-.4-.1-.2 0-1.3.2-1.3-.1 0-.2.3-.1.7-.1.1-.1.6 0 .7 0 0 0-.2.1-.3.1.3.1.6-.1.8 0-.3-.1-.7.2-1.1.1h-.1c-.2 0-.6 0-.6.1 0 .2.9.1 1.2.1.3-.3.4-.2.4-.1zm-2.3-.2c.1.1.1.1.1 0h-.1zm-.1-.2s-.1 0 0 0c-.1 0-.1 0 0 0 0 .2 0 0 0 0zm-.1.3c0 .1 0 .1 0 0 0 .1.1.1 0 0 .1.1.1 0 0 0 .1 0 .1 0 0 0l.1-.1h-.1c.1 0 .1 0 0 .1.1 0 .1 0 0 0 .1 0 0 0 0 0zm2.6-1.4c0 .1-.3.2-.6.2h.6v.2h-.1c0 .1-.1 0-.1.1 0 0 .1 0 0 .1h-.1v-.1.2-.1h-.2s0-.1.1-.1h.1v-.1h-.2c-.1 0-.1.1-.2.1h-.2v.1c.1 0 .1.1 0 .1H18s0 .1-.1.1h-.1.1-.2c0-.1.1 0 .1-.1h-.1s0-.1.1-.1.1.2.2.1h.1-.1c-.1 0-.1-.1 0-.2h-.1c-.4-.1-.2.2-.6.2h-.1c0 .1-.2.2-.2.2-.1.1-.1 0-.2.1v-.2h-.1c0 .1-.1.1-.1.1V19s0 .1-.1.1c0 0-.1 0-.1-.1v.2s-.1 0-.1-.1V19c-.2 0-.2-.1-.2-.1s0-.1.1-.1h.1c-.1 0-.1-.1-.1-.1H16v.1c0 .1.2 0 .2 0h.2v-.1h-.1c-.1 0-.1-.1-.1-.1v-.1c-.1 0-.2 0-.1-.1 0 .1.1.1.1 0-.1 0-.1-.1 0-.1v-.1s0-.1.1 0c0 0-.1 0-.1-.1h.1s0 .1.1.1V18s.1 0 .1.1v.1c0 .1 0 .1.1.1s.1.1.1.1h.1v-.1s0-.1.1-.1l.1-.1V18h.3s.1 0 .1.1v.1h.1s0 .1-.1.1c0 0 0 .1-.1.2.4-.1 1.1 0 1.3 0 0-.1.3-.1.4-.2-.1-.1-.1-.1-.4-.1-.2 0-1.1.2-1.1-.1 0-.1.2-.1.4-.1.2-.1.4 0 .6-.1 0 0-.1.1-.2.1.3.1.6-.1.9.1-.2-.1-.8.1-1.1 0H18c-.2 0-.3 0-.3.1 0 .2.7.1 1 .1.2-.1.3-.1.3 0zm-2.5.3c-.1 0-.1 0 0 0zm.5-.5c.1.1.1.1.1 0H17zm-.1-.1s-.2 0 0 0c0 .1 0 .1 0 0zm-.2.3c.2.1.2 0 0 0 .2 0 .2 0 0 0 .2-.1.2-.1 0 0l.1-.1h-.1c.2 0 .2 0 0 .1.2-.1.2-.1 0 0 .2-.1 0-.1 0 0zm1.8-1.2c.1 0 .2.1.3.1h.2v.2c0 .1-.1 0-.1.1 0 0 .1 0 0 .1h-.1v-.2h-.2s0-.1.1-.1h.1v-.1h-.4v.2h-.1v.1h-.4c0-.1.1 0 .1-.1h-.1s0-.1.1-.1.1.1.2.1h.1-.1v-.2h-.1c-.3 0-.1.1-.2.1 0 0-.1.1-.2.1v-.1h-.1l-.1.1c-.1 0-.1 0-.1.1v-.1h-.1l-.1.1v-.1s0 .1-.1.1c0 0-.1 0-.1-.1v.2s-.1 0-.1-.1v-.1c-.1.1-.1 0-.1 0s0-.1.1-.1h.1c-.1 0-.1 0-.1-.1h.1v.1h.3s.1 0 .2-.1l-.1-.1c-.1 0-.2 0-.1-.1 0 .1.1.1.1 0-.1 0-.1 0 0-.1v-.1h.1-.1.1v.1h.1v.2l.1.1V17s0-.1.1-.1l.1-.1v-.1h.4s0 .1-.1.1c0 0-.1.1-.1.2.1-.1.2 0 .4.1.3-.1.5-.1.5-.2 0-.2-.9 0-.9-.3 0 0 0-.1.1-.1v-.1c.1-.1.2-.1.3-.2 0 0 0 .1-.1.2.2 0 .2-.3.7-.2-.3.1-.3.3-.8.4l-.1.1c0 .2.9 0 .9.3-.1 0-.2.1-.6.1zm-.7-.4c0 .1 0 .1 0 0 .1.1.1.1 0 0 .1.1 0 0 0 0zm0 0c-.2 0-.2 0 0 0-.2 0-.2 0 0 0-.2 0-.2 0 0 0zm-.2.2c-.1 0-.1 0 0 0 0 .1 0 0 0 0 .1-.1.1-.1.1 0h-.1c0-.1 0-.1 0 0 0-.1 0-.1 0 0zm1.3 5.1c.1 0 .1 0 .1.1s-.1.1-.2.1l-.1 2.4h.1v.2c0 .1-.1.1-.2.1 0 .3-.2.4-.4.4-.1 0-.3-.1-.3-.3 0-.1.1-.2.2-.2s.1 0 .1.1-.2 0-.2.1 0 .1.1.1.2-.1.2-.2c0-.2-.2-.2-.4-.2-1.3-.4-2.1-1.8-2.1-2.8h-.1l.1-.2-.1.1c-.1 0-.2-.1-.2-.2s.1-.2.2-.2.2.1.2.2l.1-.2c.2.1.6.2.9.2.7 0 1.2-.3 1.5-.3.2.1.4.4.5.7zm-2.6.2c-.1 1.2.8 2.1 1.7 2.4l-1.7-2.4zm1.8 2.3c0-.1 0-.3.1-.4l-1.3-1.8h-.3l1.5 2.2zm.1-.8c0-.1 0-.3.1-.4l-.8-1.1c-.1 0-.2.1-.3.1l1 1.4zm.2-1.7c0-.2 0-.3-.1-.3s-.4.1-.7.2l.7 1c0-.2.1-.4.1-.7v-.1c-.1 0-.1-.1-.1-.1h.1zm4.3-2.6c.1 0 .1-.1.1-.1h-.1s.1 0 0-.1c0-.1-.1-.1-.1 0s-.4 0-.4-.3l.1.1h.1c.1 0 .1-.1.1-.1 0-.1-.1-.2-.3-.3-.1 0-.1-.1-.1-.1 0-.1 0-.2-.1-.4v-.2c-.1.1-.1.3.1.6.1.1.4.3.4.4 0 0 0 .1-.1.1h-.1s-.1 0-.1-.1c-.1-.1-.2-.3-.3-.4-.1-.2-.1-.3-.1-.6.1-.1-.1-.4-.1-.6v-.1h-.1s0-.1-.1-.1-.1 0-.1-.1c0 0 0 .1-.1.1h-.4c-.1 0-.1 0 0 .1v.2-.1h.1v.1h-.1v.1h.3c0 .1-.2.1-.2.3l-.1-.1-.1-.1-.1-.1c-.1 0-.1-.1-.1-.1v-.1l-.1-.1v.2s0-.1-.1-.1c0 0 0-.1-.1 0 0 0 0 .1.1.1h-.1v.2h-.1c-.1.1 0 .2.1.1v.3c0 .1.1.2.3.3l-.2.2s-.1.1-.2.1l-.1-.1h-.2.2-.1s-.1.1 0 .1v-.1s.1.1.1 0v.1s.1.1.1 0l-.1-.1v-.1s0 .1.1 0v-.1h.2s0-.1.1-.1h.1s0-.1.1-.1c0 .3.3.2.4.4-.1 0-.2-.1-.3-.1s-.2.1-.2.2.1.2.1.3h-.2c-.1 0-.1-.1-.2-.1 0 0-.1 0-.1.1h.1s-.1 0-.1.1c0 0 0 .1.1 0 0 0 0 .1.1 0h.1s0-.1.1 0h.2v-.1c0-.1-.1-.1-.1-.1 0-.1.1-.2.2-.2 0 .1.1.3.3.4.1 0 .2-.1.2-.1v.1h-.1s-.1 0-.1.1h.1s.1.1.1 0c0 0-.1.1 0 .1s0-.1.1-.1v.1h.1v-.1s.1 0 .1-.1c1 .6 1 .6 1 .4 0 .2 0 .2 0 0 0 .2 0 0 0 0zm.7.6c.1 0 .2.1.2.2l-.1.1s.1.1.1.2c-.1 0-.1 0-.2-.1 0 .1 0 .1-.1.1s-.2 0-.2-.1c0 .1.2 0 .1 0h-1.5c0 .1 0 .2-.1.3-.1-.1-.1-.2-.1-.3h-1.3c0 .1.1.1.1 0 0 .1-.1.2-.2.2H20s-.1.1-.2.1c0-.1 0-.1.1-.2-.1 0-.1 0-.1-.1s0-.2.2-.2c-.1 0 0 .2 0 .1v-1.9c-.1 0-.2 0-.3-.1.1-.1.2-.1.3-.1v-1.8c-.1 0-.1.1 0 .1-.1 0-.2-.1-.1-.2l.1-.1s-.1-.1-.1-.2c.1 0 .1 0 .2.1 0-.1 0-.1.1-.1s.2 0 .2.2c0-.1-.1-.1-.1 0 .3.1.8.2 1.1.4.3.2.7.6 1 .9l.1.1c0-.1.1-.1.3-.1-.2.3-.3.3-.3.3.4.7.8 1.4.9 2.3V20zm-1.3-2.3c-.2-.3-.6-.6-.9-.8-.2-.2-.6-.3-.9-.4v.2c-.1 0-.1 0-.1-.1v1.2c.1 0 .1 0 .1.1v.1c.1 0 .1 0 .2.1-.1.1-.1.1-.2.1.1 0 .1.1 0 .1l-.1.1V20s.1-.1.2-.1c0 .1 0 .1-.1.2h1c0-.1 0-.1.1-.1h.1c0-.1 0-.1.1-.2.1.1.1.1.1.2 0-.1.1-.1.1 0l.1.1H23s-.1-.1-.1-.2h.1c-.1-.7-.3-1.2-.7-1.8h-.1s-.1-.1 0-.1c0 0-.1.1-.2 0 0-.1 0-.1.1-.2v-.1zm4.2 2.7v.4c0 1-.2 2.1-.6 3-.3.9-.9 1.8-1.5 2.4-.3.3-.7.7-1 .9-.1.1-.4.2-2-.2-.2 0-.3-.1-.6-.1 0-.2 0-.3.1-.4.1-.2.1-.3.2-.4.1 0 .1-.1.2-.1.6-.2 1-.7 1.5-1.2.4-.6.8-1.1 1-1.8.2-.7.3-1.3.3-2h-4.5v5c.3 0 1 .1 1 .1-.1.2-.2.4-.2.8-.6-.1-1-.3-1.6-.6.4-.2.6-.2.8-.2v-4.9h-4.7c0-.2-.1-.6-.2-.7-.2-.3-.3-.4-.3-.9 0-.2-.1-.6-.3-.8-.1-.1-.7-.8-.8-.9.3-.9.9-1.8 1.5-2.4.4-.4.9-.9 1.5-1.2-.2-.2-.6-.4-.6-.9 0-.2.1-.4.2-.6-.3-.9-.8-2-1.2-2.6l.9-.4c-.2.3-.2.8-.2 1 .2-.2.4-.4.6-.7 0 .3.2.8.3 1-.2 0-.4-.1-.8 0 .1.2.6.6 1.1.3.3-.1.7-.2.7-.6 0-.1-.1-.3-.3-.3s-.2.3-.1.4c-.2-.1-.6-.9-.1-1 .3-.1.7.3.8.7 0-.2.2-.7.6-.7.4 0 .3.8.1 1 0-.2-.2-.4-.3-.4s-.2.1-.2.3c0 .2.3.4.8.4.3 0 1.1-.1 1.1-.9-.2 0-.7.2-.8.4V9.4c.2.3.6.6.8.6-.1-.3-.3-.7-.7-.9h1.7c-.3.2-.6.6-.7.9.2 0 .6-.2.8-.4v1.2c-.2-.2-.6-.4-.8-.4.1.8.8.9 1.1.9.4 0 .8-.1.8-.4 0-.2-.1-.3-.2-.3s-.2.1-.3.4c0-.2-.2-1.1.2-1.1.3 0 .4.3.6.8.1-.3.4-.8.8-.7.3.1.1.9-.1 1 .1-.1 0-.4-.1-.4-.2 0-.3.1-.3.3 0 .2.3.4.7.6.6.1 1-.2 1.1-.4-.2-.1-.4-.1-.8.1.1-.2.3-.8.3-1 .1.3.2.6.6.7 0-.2 0-.7-.2-1l.9.4c-.4.4-1 1.6-1.2 2.6.2.1.3.3.3.7 0 .4-.2.7-.6.9.6.3 1 .8 1.5 1.2.3.3.6.8.9 1.2 0 0-.1.1-.1.2-.1.1-.2.2-.2.3-.1.1-.1.2-.1.3 0 .1 0 .2.1.4l1 2c-.6 0-.4.2-.2.3zm-7-5c-.6 0-1.2.1-1.8.4-.6.2-1.1.7-1.5 1.2-.4.6-.8 1.1-1 1.8-.2.7-.3 1.3-.3 2.1h4.6v-5.5zm.1-2.2c1.6 0 2.6.4 3.2.9.3-.2.6-.4.6-.7 0-.9-2.5-1-3.7-1-1.2 0-3.7.1-3.7 1 0 .2.1.4.6.7.5-.4 1.5-.9 3-.9zm4.7 7.7c0-.7-.1-1.4-.3-2.1-.2-.7-.6-1.2-1-1.8-.4-.6-.9-.9-1.5-1.2-.6-.2-1.1-.4-1.7-.4v5.5h4.5zm11 11.1c0-.1-.1-.1-.1-.1-1.5.4-3.2-.8-4.9-1.9-1.5-1-2.8-1.9-4-1.9-.4 0-.8.1-1.1.2-.4.2-.7.6-.9 1.1-.2.4-.4.8-.6 1.1-.2.3-.3.6-.3.8 0 .2.1.4.3.7.1.2.4.3.8.6.1 0 .1.1.2.1.3.1.4.2.4.4-.6.2-1.3.4-2.1.6-.9.1-2 .2-3.1.2s-2.1-.1-3.1-.2c-.9-.1-1.6-.3-2.1-.6 0-.2.2-.3.6-.4.1 0 .1-.1.2-.1.3-.1.6-.3.8-.4.2-.2.3-.3.3-.6s-.1-.6-.3-.8c-.1-.2-.3-.6-.6-1.1-.2-.4-.6-.9-.9-1.1-.3-.2-.7-.2-1.1-.2-1.2 0-2.6.9-4 1.9-1.8 1.1-3.6 2.3-4.9 1.9-.1 0-.1 0-.1.1s0 .1.1.1c.4.2.8.4 1.2.8.6.4 1 .8 1.6.8.6 0 1.1-.1 1.8-.6.6-.3 1.2-.7 1.8-1.1 1.1-.8 2.3-1.6 3.5-1.7l-.3.3c-.3.3-.7.6-.7 1.1 0 .4.1.7.3 1.1.1.1.1.2.2.4s.2.4.2.8c0 .1.1.3.1.4.1.2.2.8 1 1.2 1 .4 2.6.8 4.9.8 2.2 0 3.9-.2 4.9-.8.8-.4 1-.9 1-1.2 0-.2.1-.3.1-.4.1-.3.1-.6.2-.8.1-.2.2-.3.2-.6.2-.3.3-.6.3-.9 0-.6-.3-.8-.7-1.1l-.3-.3c1.1.1 2.3.9 3.5 1.7.6.4 1.2.8 1.8 1.1.7.3 1.2.6 1.8.6.6 0 1-.3 1.6-.8.3-.3.8-.6 1.2-.8-.9-.2-.7-.3-.7-.4zm-14.6-1.4c.4 0 .7.3.7.7 0 .3-.2.6-.3.8-.1-.2-.1-.3-.2-.3-.2 0-.1 1.1-.8 1.1v.2c0 .2-.2.4-.4.4s-.5-.3-.5-.5v-.2c-.7 0-.6-1.1-.8-1.1-.1 0-.2.1-.2.3-.1-.2-.3-.4-.3-.8 0-.3.2-.7.7-.7h.2V29c.7.1 1.2.2 1.8.2v1.2c0 .2 0 .2.1.2zm-1.1 2.6c.1 0 .2-.1.2-.2s-.1-.2-.2-.2-.2.1-.2.2.1.2.2.2zm1.5-1.5c.1-.1.1-.3.1-.4 0-.2-.1-.4-.4-.4-.6 0-.4.8-.7.8-.1 0-.2-.1-.2-.2 0-.2.3-.4.3-.8s-.3-.6-.6-.8c-.3.2-.6.6-.6.8 0 .3.3.6.3.8 0 .1-.1.2-.2.2-.2 0-.1-.8-.7-.8-.3 0-.4.3-.4.4 0 .1 0 .2.1.4l.2-.2c.4 0 .2 1.1.8 1.1.2 0 .3-.1.3-.3 0-.1-.1-.2-.1-.3 0-.1.1-.2.2-.2s.2 0 .2.2c0 .1-.1.2-.1.3s.1.3.3.3c.4 0 .3-1.1.8-1.1.3 0 .3.1.4.2zm.3-4.1c.7.1 1.5.3 1.9.2l-.1.1c-.2.2-.4.3-.7.6-.7.4-1.3.7-1.8.7-.6 0-1.3-.1-2.1-.3-.7-.2-1.3-.4-1.8-.7-.2.2-.6.2-.9.1-.3-.1-.6-.6-.6-.8v-.1l-.7-.7c-.7-.7-1.1-1.6-1.5-2.4-.1-.4-.3-.9-.3-1.3.6.2.8 0 1-.2.1 0 .1.2.1.2.7 0 1-.4 1.1-.8.1.4.1.8.3 1.1.2.7.6 1.2 1 1.8.1.2.3.3.4.4.1 0 .2-.1.3-.1.2 0 .4.1.7.3.2.2.2.4.2.7 1.3.4 2.5.8 3.5 1.2zM17.4 26c.1 0 .1.1.2.1 0-.1-.1-.2-.2-.4-.1-.1-.3-.2-.6-.2-.4 0-.8.4-1 .6-.1 0-.2 0-.3-.1 0 .1.1.2.1.3-.2.3-.3.7-.3.9 0 .1.2.4.4.7.2.1.3.1.6 0-.1-.1-.2-.1-.3-.2-.1 0-.2-.1-.2-.2v-.1c0-.1 0-.2.1-.3v-.3h.1c.1.1.3.1.4.1 0 0 .1 0 .1-.1.1-.1 0-.3-.2-.4l-.1-.4.1-.1c.1-.1.1-.2.2-.2.5.1.6.1.9.3zm.7 1.9c.2 0 .4-.2.4-.4s-.2-.4-.4-.4-.4.2-.4.4c-.1.3.2.4.4.4zm1.9.7c.2 0 .4-.2.4-.4s-.2-.4-.4-.4-.4.2-.4.4c0 .1.2.4.4.4zM20 5c-.2-.2-.4-.4-.4-.8.2 0 .6.2.8.4V3.5c-.3.3-.5.5-.9.5 0-.2.2-.6.4-.8h-1.1c.2.3.4.6.4.8-.2 0-.6-.2-.8-.4v1.1c.2-.2.4-.4.8-.4 0 .3-.2.6-.4.8H20zm-1.6 1.4c.1.4.6.8 1 .8s.9-.3 1-.8h-2zm1.2-.4h.8c-.1-.4-.4-.8-.8-.8V6zm-.4 0v-.8c-.4.1-.8.4-.8.8h.8zm.8 1.5c-.1 0-.2.1-.3.1V9h.3V7.5zm-1.1 1.6h.3V7.7c-.1 0-.2-.1-.3-.1v1.5zm1.2-1.8c0 .2.1.3.3.3s.3-.1.3-.3c0-.2-.1-.3-.3-.3s-.3.1-.3.3zm1-.1c.2 0 .3-.1.3-.3 0-.1-.1-.2-.3-.2s-.3.1-.3.3c0 .1.2.2.3.2zM22 7c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c0 .2.1.3.3.3zm2.2.8c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c0 .2.2.3.3.3zm-.5-.6c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c-.1.2 0 .3.3.3zm-.9-.2c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c-.1.1.2.3.3.3zm1.8 2.4c-.2 0-.3.1-.3.3 0 .2.1.3.3.3s.3-.1.3-.3c0-.2-.1-.3-.3-.3zm.1-.7c-.2 0-.3.1-.3.3 0 .2.1.3.3.3s.3-.1.3-.3c0-.2-.1-.3-.3-.3zm-.4-.5c0 .2.1.3.3.3s.4-.1.4-.3c0-.2-.1-.3-.3-.3s-.4.1-.4.3zm-5.9-.5c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c0 0 .2.3.3.3zm-.8-.5c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c.1.2.2.3.3.3zm-.7-.2c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c-.1.2.1.3.3.3zm-2.3.8c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c0 .2.1.3.3.3zm.6-.6c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c-.1.2.2.3.3.3zm.9-.2c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.3.1-.3.3c-.1.1.1.3.3.3zm-1.5 2.8c0-.2-.1-.3-.3-.3s-.3 0-.3.3c0 .2.1.3.3.3.1 0 .3-.1.3-.3zm-.2-.8c0-.2-.1-.3-.3-.3-.2 0-.3.1-.3.3 0 .2.1.3.3.3.2 0 .3-.2.3-.3zm-.2-.5c.2 0 .3-.1.3-.3 0-.2-.1-.3-.3-.3s-.4.1-.4.3c0 .1.3.3.4.3zm7.7.3c-.1.1-.4.4-.4.8 0 .2.2.6.3.8.1-.3.4-.4.4-.8 0-.3-.2-.5-.3-.8zm-4.9 0c-.2.3-.3.6-.3.9 0 .3.3.4.4.8.1-.3.3-.6.3-.8 0-.5-.3-.8-.4-.9z"></path>
                    <image src="${url.resourcesPath}/assets/images/moj-logotype-crest.png" xlink:href="" class="moj-header__logotype-crest-fallback-image" width="40" height="40"></image>
                </svg>
                <a class="moj-header__link moj-header__link--organisation-name" href="#">${properties.kcOrganisationName!}</a>
                <a class="moj-header__link moj-header__link--service-name" href="#">${properties.kcServiceName!}</a>
            </div>
            <div class="moj-header__content">

            </div>
        </div>
    </header>

    <#-- End GOV.UK Template header -->


    <div class="govuk-width-container">
        <div><#nested "back"></div>

        <main class="govuk-main-wrapper app-main-class" id="main-content" role="main">
            <div id="kc-container" class="${properties.kcContainerClass!}">
                <div id="kc-container-wrapper" class="${properties.kcContainerWrapperClass!}">

                    <#-- The GOV.UK Template header is included above, with Keycloak’s nested header section inside it, so remove the Keycloak template’s header HTML -->
                    <#-- <div id="kc-header" class="${properties.kcHeaderClass!}">
                        <div id="kc-header-wrapper" class="${properties.kcHeaderWrapperClass!}"><#nested "header"></div>
                    </div>-->

                    <#if realm.internationalizationEnabled>
                        <div id="kc-locale" class="${properties.kcLocaleClass!}">
                            <div id="kc-locale-wrapper" class="${properties.kcLocaleWrapperClass!}">
                                <div class="kc-dropdown" id="kc-locale-dropdown">
                                    <a href="#" id="kc-current-locale-link">${locale.current}</a>
                                    <ul>
                                        <#list locale.supported as l>
                                            <li class="kc-dropdown-item"><a href="${l.url}">${l.label}</a></li>
                                        </#list>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </#if>

                    <div id="kc-content" class="${properties.kcContentClass!}">
                        <div id="kc-content-wrapper" class="${properties.kcContentWrapperClass!}">

                            <#if displayMessage && message?has_content>
                                <#if message.type = 'error'>
                                    <div class="govuk-error-summary" role="group" aria-labelledby="error-summary-heading-example-1" tabindex="-1">
                                        <h1 class="govuk-heading-m govuk-error-summary__title" id="error-summary-heading-example-1">
                                            There is a problem with this form
                                        </h1>

                                        <ul class="govuk-error-summary__list" id="error-details">
                                            <li>${message.summary}</li>
                                        </ul>
                                    </div>
                                <#else>
                                    <div class="${properties.kcFeedbackAreaClass!}">
                                        <div class="alert alert-${message.type}"><p>
                                                <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                                                <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                                                <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                                                <span class="kc-feedback-text">${message.summary}</span></p>
                                        </div>
                                    </div>
                                </#if>
                            </#if>

                            <div id="kc-form" class="${properties.kcFormAreaClass!}">
                                <div id="kc-form-wrapper" class="${properties.kcFormAreaWrapperClass!}">
                                    <#nested "form">
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
    

    <#-- Start GOV.UK Template footer -->

    <footer class="govuk-footer" role="contentinfo">
        <div class="govuk-width-container ">
            <div class="govuk-footer__meta">
                <div class="govuk-footer__meta-item govuk-footer__meta-item--grow">

                    <svg role="presentation" focusable="false" class="govuk-footer__licence-logo" xmlns="http://www.w3.org/2000/svg" viewbox="0 0 483.2 195.7" height="17" width="41">
                        <path fill="currentColor" d="M421.5 142.8V.1l-50.7 32.3v161.1h112.4v-50.7zm-122.3-9.6A47.12 47.12 0 0 1 221 97.8c0-26 21.1-47.1 47.1-47.1 16.7 0 31.4 8.7 39.7 21.8l42.7-27.2A97.63 97.63 0 0 0 268.1 0c-36.5 0-68.3 20.1-85.1 49.7A98 98 0 0 0 97.8 0C43.9 0 0 43.9 0 97.8s43.9 97.8 97.8 97.8c36.5 0 68.3-20.1 85.1-49.7a97.76 97.76 0 0 0 149.6 25.4l19.4 22.2h3v-87.8h-80l24.3 27.5zM97.8 145c-26 0-47.1-21.1-47.1-47.1s21.1-47.1 47.1-47.1 47.2 21 47.2 47S123.8 145 97.8 145" />
                    </svg>
                    <span class="govuk-footer__licence-description">
            All content is available under the
            <a class="govuk-footer__link" href="https://www.nationalarchives.gov.uk/doc/open-government-licence/version/3/" rel="license">Open Government Licence v3.0</a>, except where otherwise stated
          </span>
                </div>
                <div class="govuk-footer__meta-item">
                    <a class="govuk-footer__link govuk-footer__copyright-logo" href="https://www.nationalarchives.gov.uk/information-management/re-using-public-sector-information/uk-government-licensing-framework/crown-copyright/">© Crown copyright</a>
                </div>
            </div>
        </div>
    </footer>

    <div id="global-app-error" class="app-error hidden"></div>

    <script src="${url.resourcesPath}/assets/js/all.js"></script>
    <script>
        window.GOVUKFrontend.initAll()
    </script>
    <script src="${url.resourcesPath}/assets/js/cookie.js"></script>

    <#-- End GOV.UK Template footer -->
    </body>
    </html>
</#macro>
