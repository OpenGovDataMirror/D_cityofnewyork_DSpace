<%--

    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/

--%>
<%--
  - Feedback form JSP
  -
  - Attributes:
  -    feedback.problem  - if present, report that all fields weren't filled out
  -    authenticated.email - email of authenticated user, if any
  --%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.commons.lang.StringEscapeUtils" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.dspace.org/dspace-tags.tld" prefix="dspace" %>

<%
    boolean problem = (request.getParameter("feedback.problem") != null);
    String email = request.getParameter("email");

    if (email == null || email.equals(""))
    {
        email = (String) request.getAttribute("authenticated.email");
    }

    if (email == null)
    {
        email = "";
    }

    String feedback = request.getParameter("feedback");
    if (feedback == null)
    {
        feedback = "";
    }

    String fromPage = request.getParameter("fromPage");
    if (fromPage == null)
    {
		fromPage = "";
    }
%>

<dspace:layout titlekey="jsp.feedback.form.title">
    <%-- <h1>Feedback Form</h1> --%>
    <h1><fmt:message key="jsp.feedback.form.title"/></h1>

<%
    if (problem)
    {
%>
        <%-- <p><strong>Please fill out all of the information below.</strong></p> --%>
        <p><strong><fmt:message key="jsp.feedback.form.text2"/></strong></p>
<%
    }
%>
    <br>
    <p>Please send an email to municipal-library-admins at records dot nyc dot gov to ask questions about the
        Government Publications Portal or provide feedback.</p>
<%--    <form action="<%= request.getContextPath() %>/contact" method="post">--%>
<%--        <input type="hidden" name="csrf_token" value="<%= session.getAttribute("csrfToken")%>">--%>
<%--        <center>--%>
<%--            <table>--%>
<%--                <tr>--%>
<%--                    <td class="submitFormLabel"><label for="temail"><fmt:message key="jsp.feedback.form.email"/></label></td>--%>
<%--                    <td><input type="text" name="email" id="temail" size="50" value="<%=StringEscapeUtils.escapeHtml(email)%>" /></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td class="submitFormLabel"><label for="tfeedback"><fmt:message key="jsp.feedback.form.comment"/></label></td>--%>
<%--                    <td><textarea name="feedback" id="tfeedback" rows="6" cols="50"><%=StringEscapeUtils.escapeHtml(feedback)%></textarea></td>--%>
<%--                </tr>--%>
<%--                <tr>--%>
<%--                    <td colspan="2" align="center">--%>
<%--                    <input type="submit" name="submit" value="<fmt:message key="jsp.feedback.form.send"/>" />--%>
<%--                    </td>--%>
<%--                </tr>--%>
<%--            </table>--%>
<%--        </center>--%>
<%--    </form>--%>

</dspace:layout>
