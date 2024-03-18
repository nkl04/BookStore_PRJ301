import dal.GenreDAO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.DataItem;

@WebServlet("/chartData")
public class ChartDataServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Simulated data - replace with your actual data retrieval logic
        GenreDAO gdao = new GenreDAO();
        List<DataItem> data = gdao.chartData();

        // Convert data to JSON manually
        StringBuilder jsonData = new StringBuilder();
        jsonData.append("[");
        for (int i = 0; i < data.size(); i++) {
            DataItem item = data.get(i);
            jsonData.append("{\"category\": \"" + item.getCategory() + "\", \"value\": " + item.getValue() + "}");
            if (i < data.size() - 1) {
                jsonData.append(",");
            }
        }
        jsonData.append("]");

        // Set content type and character encoding
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Write JSON data to the response
        PrintWriter out = response.getWriter();
        out.print(jsonData.toString());
        out.flush();
    }
}
