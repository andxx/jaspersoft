<%--
  ~ Copyright (C) 2005 - 2011 Jaspersoft Corporation. All rights reserved.
  ~ http://www.jaspersoft.com.
  ~
  ~ Unless you have purchased  a commercial license agreement from Jaspersoft,
  ~ the following license terms  apply:
  ~
  ~ This program is free software: you can redistribute it and/or  modify
  ~ it under the terms of the GNU Affero General Public License  as
  ~ published by the Free Software Foundation, either version 3 of  the
  ~ License, or (at your step) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful,
  ~ but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  ~ GNU Affero  General Public License for more details.
  ~
  ~ You should have received a copy of the GNU Affero General Public  License
  ~ along with this program. If not, see <http://www.gnu.org/licenses/>.
  --%>

<%@ taglib prefix="t" uri="http://tiles.apache.org/tags-tiles" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<t:insertTemplate template="/WEB-INF/jsp/templates/page.jsp">
    <t:putAttribute name="pageTitle"><spring:message
            code="resource.analysisConnection.dataSource.locate.page.title"/></t:putAttribute>
    <t:putAttribute name="bodyID" value="addResource_locateDatatype"/>

    <t:putAttribute name="bodyClass" value="oneColumn flow wizard"/>

    <t:putAttribute name="bodyContent">
    	<form method="post" id="mon" >
        <t:insertTemplate template="/WEB-INF/jsp/templates/container.jsp">
            <t:putAttribute name="containerClass" value="column decorated primary"/>
            <t:putAttribute name="containerTitle"><spring:message code='addResources.analysisClient.MondrianLocate.title' javaScriptEscape='true'/></t:putAttribute>

            <t:putAttribute name="headerContent">
                <script type="text/javascript"
                        src="${pageContext.request.contextPath}/scripts/resource.base.js"></script>
                <script type="text/javascript"
                        src="${pageContext.request.contextPath}/scripts/resource.locate.js"></script>
                <script type="text/javascript"
                        src="${pageContext.request.contextPath}/scripts/resource.analysisConnection.mondrian.locate.js"></script>
                  <jsp:include page="analysisClientConnectionMondrianLocateState.jsp"/>
            </t:putAttribute>

            <t:putAttribute name="swipeScroll" value="${isIPad}"/>

            <t:putAttribute name="bodyContent">
                
                <div id="flowControls"></div>
                <div id="stepDisplay">
                    <fieldset class="row instructions">
                        <legend class="offLeft"><span><spring:message code='addResources.analysisClient.MondrianLocate.instructions' javaScriptEscape='true'/></span></legend>
                        <h2 class="textAccent02"><spring:message code='addResources.analysisClient.MondrianLocate.locateMondrianConSource' javaScriptEscape='true'/></h2>
                        <h4><!--NOTE: keep h4 markup, but leave empty --></h4>

                        <p class="warning">Error or warning here.</p>
                    </fieldset>

                    <fieldset class="row inputs oneColumn">
                        <legend class="offLeft"><span><spring:message code='addResources.analysisClient.MondrianLocate.userInputs' javaScriptEscape='true'/></span></legend>

                        <t:insertTemplate template="/WEB-INF/jsp/templates/container.jsp">
                            <t:putAttribute name="containerClass" value="column primary"/>
                            <t:putAttribute name="containerTitle"><spring:message
                                    code="resource.analysisConnection.connectionType"/>:</t:putAttribute>
                            <t:putAttribute name="headerContent">
                                <spring:bind path="connectionWrapper.type">
                                    <label class="control select inline" for="type" title="Connection type">
                                        <span class="wrap offLeft"><spring:message
                                                code="resource.analysisConnection.connectionType"/></span>
                                        <select id="type" name="${status.expression}">
                                            <option
                                                    <c:if test="${connectionWrapper.type=='olapMondrianCon'}">selected="selected"</c:if>
                                                    value="olapMondrianCon" name="${status.value}">Mondrian
                                            </option>
                                            <option
                                                    <c:if test="${connectionWrapper.type=='olapXmlaCon'}">selected="selected"</c:if>
                                                    value="olapXmlaCon" name="${status.value}">XML/A Connection
                                            </option>
                                        </select>
                                    </label>
                                </spring:bind>
                            </t:putAttribute>
                            <t:putAttribute name="bodyContent">
                                <fieldset class="group locationSelector">
                                    <legend class="offLeft"><span><spring:message code='addResources.analysisClient.MondrianLocate.locateResource' javaScriptEscape='true'/></span></legend>
                                    <ul class="list locations">
                                        <spring:bind path="connectionWrapper.source">
                                            <c:if test="${not (connectionWrapper.parentFlowObject != null && connectionWrapper.parentFlowObject.aloneEditMode)}">
                                                <li id="create" class="leaf">
													<div class="control radio<c:if test="${status.error and status.value == 'LOCAL'}"> error</c:if>">
														<label class="wrap" for="LOCAL" title="<spring:message code='addResources.analysisClient.defineDataSource'/>">
															<spring:message code='addResources.analysisClient.MondrianLocate.defineMondrianConection' javaScriptEscape='true'/>
														</label>
														<input id="LOCAL" class="" type="radio" name="${status.expression}"
                                                               value="LOCAL"
                                                               <c:if test='${status.value=="LOCAL"}'>checked="true"</c:if>/>
                                                        <c:if test="${status.error and status.value == 'LOCAL'}">
                                                            <span class="message warning">${status.errorMessage}</span>
                                                        </c:if>
													</div>
                                                </li>
                                            </c:if>
                                            <li id="fromRepo" class="leaf">
												<div class="control radio complex">
													<label class="wrap" for="CONTENT_REPOSITORY"
														   title="<spring:message code='resource.report.repository'/>">
															<spring:message code='addResources.analysisClient.MondrianLocate.selectMondrianConection' javaScriptEscape='true'/>
													</label>
													<input id='CONTENT_REPOSITORY' name="${status.expression}" type="radio" value="CONTENT_REPOSITORY"
                                                           <c:if test='${status.value!="LOCAL"}'>checked="true"</c:if> />
												</div>
                                                </spring:bind>
                                                <spring:bind path="connectionWrapper.connectionUri">
                                                    <label class="control browser<c:if test="${status.error and connectionWrapper.source != 'LOCAL'}"> error</c:if>" for="resourceUri">
                                                        <input id="resourceUri" type="text" name="${status.expression}" value="${status.value}"
                                                               <c:if test="${empty status.value && connectionWrapper.source == 'LOCAL'}">disabled="disabled"</c:if>/>
                                                        <button id="browser_button" class="button action" <c:if test="${empty status.value && connectionWrapper.source == 'LOCAL'}">disabled="disabled"</c:if>>
                                                            <span class="wrap">
                                                                <spring:message code="button.browse"/>
                                                                <span class="icon"></span>
                                                            </span>
                                                        </button>
                                                        <c:if test="${status.error and connectionWrapper.source != 'LOCAL'}">
                                                            <span class="message warning">${status.errorMessage}</span>
                                                        </c:if>
                                                    </label>
                                                </spring:bind>
                                            </li>
                                    </ul>
                                </fieldset>
                            </t:putAttribute>
                        </t:insertTemplate>
                    </fieldset>
                    <!--/.row.inputs-->
                </div>
                <t:putAttribute name="footerContent">
                    <fieldset id="wizardNav">
                        <button id="previous" type="submit" class="button action up" name="_eventId_back"><span
                                class="wrap"><spring:message
                                code='button.previous'/></span><span class="icon"></span></button>
                        <button id="next" type="submit" class="button action up" name="_eventId_next"><span
                                class="wrap"><spring:message
                                code='button.next'/></span><span class="icon"></span></button>
                        <button id="cancel" type="submit" name="_eventId_cancel" class="button action up"><span
                                class="wrap"><spring:message
                                code='button.cancel'/></span><span class="icon"></span></button>
                        <button id="chooseType" type="submit" class="hidden" name="_eventId_changeCombo"><span
                            class="wrap"><spring:message
                            code='button.next'/></span><span class="icon"></span></button>
                    </fieldset>
                </t:putAttribute>
            </t:putAttribute>
        </t:insertTemplate>

        <!--/.row.inputs-->
        <input type="hidden" name="_flowExecutionKey" value="${flowExecutionKey}"/>
        <!--/#stepDisplay-->
        <t:insertTemplate template="/WEB-INF/jsp/templates/selectFromRepository.jsp">
            <t:putAttribute name="containerClass">hidden</t:putAttribute>
            <t:putAttribute name="bodyContent">
                <ul id="OLAPTreeRepoLocation"> </ul>
            </t:putAttribute>
        </t:insertTemplate>

        <div id="ajaxbuffer" class="hidden" ></div>
        </form>
    </t:putAttribute>
</t:insertTemplate>