import com.cugb.javaee.consumer.SoldOutConsumer;

public class ApplicationStartup {

    public static void main(String[] args) {
        // 启动消息消费者
        try {
            new SoldOutConsumer().main(args);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}