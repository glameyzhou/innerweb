package com.glamey.innerweb.controller.front;

import com.glamey.innerweb.controller.BaseController;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.lang.management.ManagementFactory;
import java.lang.management.MonitorInfo;
import java.lang.management.ThreadInfo;
import java.lang.management.ThreadMXBean;

/**
 * Created with IntelliJ IDEA.
 * User: zy
 * To change this template use File | Settings | File Templates.
 */
@Controller
public class ConsoleFrontManager extends BaseController {
    @RequestMapping(value = "/monitor/console.htm", method = RequestMethod.GET)
    public ModelAndView monitorJVM(HttpServletRequest request, HttpServletResponse response) throws Exception {
        PrintWriter out = response.getWriter();
        response.setContentType("text/html; charset=UTF-8");

        ThreadMXBean threadMXBean = ManagementFactory.getThreadMXBean();
        threadMXBean.setThreadContentionMonitoringEnabled(true);

        long allThreadIds[] = threadMXBean.getAllThreadIds();
        ThreadInfo threadInfos[] = threadMXBean.getThreadInfo(allThreadIds, Integer.MAX_VALUE);

        for (ThreadInfo threadInfo : threadInfos) {
            out.println("Thread Id = " + threadInfo.getThreadId() + "<br/>");
            out.println("Thread Name = " + threadInfo.getThreadName() + "<br/>");
            out.println("Thread State = " + threadInfo.getThreadState() + "<br/>");
            out.println("Thread Lock Name = " + threadInfo.getLockName() + "<br/>");
            out.println("Thread Lock Owner = [id=" + threadInfo.getLockOwnerId() + "][name=" + threadInfo.getLockOwnerId() + "]<br/>");
            out.println("Thread CPU Time = " + threadMXBean.getThreadCpuTime(threadInfo.getThreadId()) + "nanoseconds<br/>");
            /*out.println("Thread User Time = " + threadMXBean.getCurrentThreadUserTime() + "<br/>");*/
            out.println("-------------------------------Thread Stack Trace------------------------------- <br/>");
            StackTraceElement stackTraceElements[] = threadInfo.getStackTrace();
            for (StackTraceElement stackTraceElement : stackTraceElements) {
                out.println(stackTraceElement.toString() + "<br/>");
            }
            out.println("-------------------------------Thread MonitorInfo-------------------------------<br/>");
            MonitorInfo monitorInfos[] = threadInfo.getLockedMonitors();
            for (MonitorInfo monitorInfo : monitorInfos) {
                out.println("monitorInfo id = " + monitorInfo.getLockedStackDepth() + "<br/>");
                out.println("monitorInfo LockedStackFrame = " + monitorInfo.getLockedStackFrame().toString() + "<br/>");

            }
            out.println();

            out.println("<br/><br/>");

        }
        out.flush();
        return null;
    }
}
