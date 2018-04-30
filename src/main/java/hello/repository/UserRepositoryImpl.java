package hello.repository;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;

public class UserRepositoryImpl implements UserRepositoryCustom {

	private static final Logger log = LoggerFactory.getLogger(UserRepositoryImpl.class);

	public UserRepositoryImpl() {
		log.info("★user repository constracter called.");
//		try {
//			final int LOOP_MAX = 2;
//			for (int i = 0; i <= LOOP_MAX; i++) {
//				Thread.sleep(1_000);
//				log.warn("wait until" + (LOOP_MAX - i) + "seconds");
//			}
//		} catch (InterruptedException e) {
//		}

	}
}
