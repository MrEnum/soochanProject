import com.nedam.soochanProject.controller.HomeController;
import com.nedam.soochanProject.serviceImpl.StaffServiceImpl;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/applicationContext.xml")
//@Log4j
public class SampleTests {

//    @Setter(onMethod_ = {@Autowired})
    private StaffServiceImpl staffServiceImpl;

    @Test
    public void testSearch(){
        HomeController homeController;
        System.out.println("잘 작동 됩니다.");
    }

}
