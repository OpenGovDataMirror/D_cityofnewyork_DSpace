<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - HTML header for main home page
  --%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List"%>
<%@ page import="java.util.Enumeration"%>
<%@ page import="org.dspace.app.webui.util.JSPManager" %>
<%@ page import="org.dspace.core.ConfigurationManager" %>
<%@ page import="org.dspace.app.util.Util" %>
<%@ page import="org.dspace.content.Collection" %>
<%@ page import="javax.servlet.jsp.jstl.core.*" %>
<%@ page import="javax.servlet.jsp.jstl.fmt.*" %>

<%
    String title = (String) request.getAttribute("dspace.layout.title");
    String navbar = (String) request.getAttribute("dspace.layout.navbar");
    boolean locbar = ((Boolean) request.getAttribute("dspace.layout.locbar")).booleanValue();

    String siteName = ConfigurationManager.getProperty("dspace.name");
    String feedRef = (String)request.getAttribute("dspace.layout.feedref");
    boolean osLink = ConfigurationManager.getBooleanProperty("websvc.opensearch.autolink");
    String osCtx = ConfigurationManager.getProperty("websvc.opensearch.svccontext");
    String osName = ConfigurationManager.getProperty("websvc.opensearch.shortname");
    List parts = (List)request.getAttribute("dspace.layout.linkparts");
    String extraHeadData = (String)request.getAttribute("dspace.layout.head");
    String extraHeadDataLast = (String)request.getAttribute("dspace.layout.head.last");
    String dsVersion = Util.getSourceVersion();
    String generator = dsVersion == null ? "DSpace" : "DSpace "+dsVersion;
    String analyticsKey = ConfigurationManager.getProperty("jspui.google.analytics.key");
    String lastActive = (String) request.getAttribute("last.active");
%>

<!DOCTYPE html>
<html>
    <head>
        <title><%= siteName %>: <%= title %></title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="Generator" content="<%= generator %>" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="<%= request.getContextPath() %>/favicon.ico" type="image/x-icon"/>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/jquery-ui-1.10.3.custom/redmond/jquery-ui-1.10.3.custom.css" type="text/css" />
        <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/bootstrap-theme.min.css" type="text/css" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/static/css/bootstrap/dspace-theme.css" type="text/css" />
<%
    if (!"NONE".equals(feedRef))
    {
        for (int i = 0; i < parts.size(); i+= 3)
        {
%>
        <link rel="alternate" type="application/<%= (String)parts.get(i) %>" title="<%= (String)parts.get(i+1) %>" href="<%= request.getContextPath() %>/feed/<%= (String)parts.get(i+2) %>/<%= feedRef %>"/>
<%
        }
    }

    if (osLink)
    {
%>
        <link rel="search" type="application/opensearchdescription+xml" href="<%= request.getContextPath() %>/<%= osCtx %>description.xml" title="<%= osName %>"/>
<%
    }

    if (extraHeadData != null)
        { %>
<%= extraHeadData %>
<%
        }
%>

        <script type='text/javascript' src="<%= request.getContextPath() %>/static/js/jquery/jquery-1.10.2.min.js"></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/jquery/jquery-ui-1.10.3.custom.min.js'></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/bootstrap/bootstrap.min.js'></script>
        <script type='text/javascript' src='<%= request.getContextPath() %>/static/js/holder.js'></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/utils.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath() %>/static/js/choice-support.js"> </script>
        <dspace:include page="/layout/google-analytics-snippet.jsp" />

    <%
    if (extraHeadDataLast != null)
    { %>
        <%= extraHeadDataLast %>
    <%
    }
    %>


<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="<%= request.getContextPath() %>/static/js/html5shiv.js"></script>
  <script src="<%= request.getContextPath() %>/static/js/respond.min.js"></script>
<![endif]-->
    </head>

    <%-- HACK: leftmargin, topmargin: for non-CSS compliant Microsoft IE browser --%>
    <%-- HACK: marginwidth, marginheight: for non-CSS compliant Netscape browser --%>
    <body class="undernavigation">
<a class="sr-only" href="#content">Skip navigation</a>
<dspace:include page="/layout/header-nyc.jsp" />
<header class="navbar navbar-inverse">
    <%
    if (!navbar.equals("off"))
    {
%>
            <div class="container">
                <dspace:include page="<%= navbar %>" />
            </div>
<%
    }
    else
    {
    %>
        <div class="container">
            <dspace:include page="/layout/navbar-minimal.jsp" />
        </div>
<%
    }
%>
</header>

<main id="content" role="main">
    <!-- Previous logon (access) notification -->
    <% if (lastActive != null) { %>
        <div class="container alert alert-info">
            <a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
            Last login: <%= lastActive %>
        </div>
    <% } %>

    <div class="container">
        <div class="row">
            <div class="col-md-12 brand" style="text-align: center">
                <a href="<%= request.getContextPath() %>/">
                    <img src="<%= request.getContextPath() %>/static/img/doris-logo.png">
                </a>
            </div>
        </div>
    </div>
</div>
<br/>
                <%-- Location bar --%>
<%
    if (locbar)
    {
%>
<div class="container">
    <dspace:include page="/layout/location-bar.jsp" />
</div>
<%
    }
%>

    <%-- Page contents --%>
    <div class="container">
            <%
    Collection collection = (Collection) request.getAttribute("collection");
    if(collection != null && request.getAttribute("dspace.layout.sidebar") != null) {
%>
        <p>Welcome to the Government Publications Portal. The Government Publications Portal is a permanent searchable
        digital repository for all of New York City???s recent agency publications. The portal is maintained by the
        Municipal Library at the New York City Department of Records and Information Services (DORIS). The portal is
        part of New York City government???s ongoing mission to make government information publicly and easily
        accessible. The <a
        href="http://library.amlegal.com/nxt/gateway.dll/New%20York/charter/newyorkcitycharter/chapter49officersandemployees?f=templates$fn=default.htm$3.0$vid=amlegal:newyork_ny$anc=JD_1133"
        target="_blank" rel="noopener noreferrer">New York City Charter, Section 1133</a>, requires agencies to submit
        digital copies of all publications to the Library for permanent
        access and storage. Beginning July 1, 2019, DORIS will maintain a list of all required reports on its website
        for public perusal. Effective January 1, 2020, more information will be available including not only access
        to the report but citation to the law requiring the publication, date or reporting period covered. Should
        the agencies concerned not submit the report within the required time limit, DORIS will issue a request for the
        report to the agency. Such requests will be published on the government publications website in place of the
        report until such report is published.
    </p>
        <p>For older agency publications on paper, please consult our <a href="https://nycrecords.bywatersolutions.com/"
        target="_blank" rel="noopener noreferrer">electronic catalog</a>.</p>
        <p>To find publications, search by keyword, such as agency name, subject, title, report type, or date. Once you
        have search results, you can sort them further using filters, including by relevance, by date, or with just one
        letter of the alphabet.</p>
        <br/>
        <div class="row">
            <div class="col-md-9"> <%
    }
    else if (request.getAttribute("dspace.layout.sidebar") != null) {
%>
                <div class="row">
                    <div class="col-md-9">
                            <%
    }
%>